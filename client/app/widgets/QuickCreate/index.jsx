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

// Question: These functions are related to props/state but they don't impact them in anyway.
// They are pure functions in that they take some input and give an output
// there is no modification or dependency from props/state. That's why I hoisted these out
// but it seems like other refactors kept similar methods inside the component.
const labelExists = (checkboxes: Checkbox[], compareLabel: string) => checkboxes.filter(
  (checkbox: Checkbox) => checkbox.label.toLowerCase() === compareLabel.toLowerCase(),
).length;

const addToCheckboxes = (
  { name, id, slug }: NewCheckbox,
  checkboxes: Checkbox[],
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

/* Question: Just want to confirm this is an ok use of useReducer
 * Reason 1: consecutive setState() calls for different state
 * (e.g. onChange -> setModalKey(newKey); setOpen(true); setBody(newBody);)
 *
 * Reason 2: Need to synchronize the state of checkboxes. I consistently saw checkbox state as
 * the old state in onSubmit. I'm thinking when the onSubmit callback was defined in that render
 * it closed over the previous state of the checkboxes,s o everytime it was invoked I saw the
 * old state for the checkbox which gave me stale checkbox state.
 * I first fixed this by setting a flag when onSubmit was invoked (so promised resolved)
 * and then using an effect based off that flag. Seemed a little hacky.
 * I realized I could synchronize the state by handling the update in a reducer.
 * And again, the consecutive setState calls pushed me in this direction as well.
 */
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
    {
      checkboxes, accordionOpen, tagKey, body, open, modalKey,
    },
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
          // Question: Previously there were instance methods that were solely for unpacking
          // related state, prop variables, and then returning jsx/component.
          // this seems to be an unnecessary step IMO. Is it okay just to inline?
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
      {/* Question: Again just inlining the input rather than invoking a method that returns jsx.
      The logic is being able to just look at the output of the render method and understanding
      what this component actually is vs tracing function/method calls */}
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
