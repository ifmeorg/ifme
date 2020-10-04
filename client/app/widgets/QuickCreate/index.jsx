// @flow
import React, { useReducer } from 'react';
import Modal from 'components/Modal';
import Input from 'components/Input';
import type { Checkbox } from 'components/Input/utils';
import { Utils } from 'utils';
import DynamicForm from 'components/Form/DynamicForm';
import css from './QuickCreate.scss';

// value - e.g. category.id
// label - e.g. category.name
// checked - i.e. is category used in Moment?

export type Props = {
  checkboxes: Checkbox[],
  placeholder?: string,
  name: string,
  id: string,
  label: string,
  formProps: any,
};

export type State = {
  checkboxes: Checkbox[],
  open: boolean,
  modalKey?: string,
  tagKey?: string,
  body?: any,
  accordionOpen: boolean,
};

type NewCheckbox = {
  name: string,
  id: string,
  slug: string,
  success?: boolean,
};

type OnSubmitResponse = {
  data: NewCheckbox,
  status: number,
  statusText: string,
  headers: Object,
  request: Object,
  config: Object,
};

// utils
const alpha = (a: string, b: string) => {
  if (a.toLowerCase() > b.toLowerCase()) return 1;
  if (a.toLowerCase() < b.toLowerCase()) return -1;
  return 0;
};

const sortAlpha = (checkboxes: Checkbox[]): Checkbox[] =>
  // eslint-disable-next-line implicit-arrow-linebreak
  checkboxes.sort((a: Checkbox, b: Checkbox) => alpha(a.label, b.label));

const labelExists = (checkboxes: Checkbox[], compareLabel: string) =>
  checkboxes.filter(
    (checkbox: Checkbox) =>
      checkbox.label.toLowerCase() === compareLabel.toLowerCase()
  ).length;

const addToCheckboxes = (
  { name, id, slug }: NewCheckbox,
  checkboxes: Checkbox[]
) => {
  const newCheckboxes = checkboxes.slice(0);
  newCheckboxes.push({
    id: slug,
    label: name,
    value: id,
    checked: true,
  });
  return sortAlpha(newCheckboxes);
};

// reducer types
type OnChangePayload = {
  label: string,
  checkboxes: Checkbox[],
  body: any,
};
type CheckboxData = {
  name: string,
  id: string,
  slug: string,
  success?: boolean,
};
type OnSubmitPayload = CheckboxData;
type OnChangeAction = { type: 'ON_CHANGE', payload: OnChangePayload };
type OnSubmitAction = { type: 'ON_SUBMIT', payload: OnSubmitPayload };
type Action = OnChangeAction | OnSubmitAction;
// reducer constants
export const ON_CHANGE = 'ON_CHANGE';
export const ON_SUBMIT = 'ON_SUBMIT';
const quickCreateReducer = (state: State, action: Action) => {
  switch (action.type) {
    case ON_CHANGE: {
      return {
        ...state,
        checkboxes: action.payload.checkboxes,
        label: action.payload.label,
        open: true,
        modalKey: Utils.randomString(),
        body: action.payload.body,
      };
    }
    case ON_SUBMIT: {
      return {
        ...state,
        open: false,
        accordionOpen: true,
        tagKey: Utils.randomString(),
        modalKey: Utils.randomString(),
        checkboxes: addToCheckboxes(action.payload, state.checkboxes),
      };
    }
    default:
      throw new Error();
  }
};

export const QuickCreate = ({
  placeholder,
  name,
  id,
  label,
  checkboxes: checkboxesProp,
  formProps,
}: Props) => {
  const [
    { checkboxes, accordionOpen, tagKey, body, open, modalKey },
    dispatch,
  ] = useReducer(quickCreateReducer, {
    checkboxes: checkboxesProp,
    open: false,
    accordionOpen: checkboxesProp.some((cb) => cb.checked),
    modalKey: undefined,
    tagKey: undefined,
    body: undefined,
  });

  const onSubmit = (response: OnSubmitResponse) => {
    const { data } = response;
    if (data && data.success) {
      dispatch({ type: ON_SUBMIT, payload: data });
    }
  };

  const onChange = ({
    label: onChangeLabel,
    checkboxes: changeCheckboxes,
  }: {
    label: string,
    checkboxes: Checkbox[],
  }) => {
    if (!labelExists(checkboxes, onChangeLabel)) {
      dispatch({
        type: ON_CHANGE,
        payload: {
          label: onChangeLabel,
          checkboxes: changeCheckboxes,
          body: (
            <DynamicForm
              nameValue={onChangeLabel}
              formProps={formProps}
              onSubmit={onSubmit}
            />
          ),
        },
      });
    }
  };

  return (
    <div>
      <Input
        id={id}
        type="tag"
        name={name}
        label={label}
        checkboxes={checkboxes}
        placeholder={placeholder}
        accordionOpen={accordionOpen}
        onChange={onChange}
        key={tagKey}
        accordion
        dark
      />
      <div className={css.modal}>
        <Modal body={body} title={label} open={open} modalKey={modalKey} />
      </div>
    </div>
  );
};
