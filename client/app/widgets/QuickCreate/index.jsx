// @flow
import React, { useState } from 'react';
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

const alpha = (a: string, b: string) => {
  if (a.toLowerCase() > b.toLowerCase()) return 1;
  if (a.toLowerCase() < b.toLowerCase()) return -1;
  return 0;
};

const sortAlpha = (checkboxes: Checkbox[]): Checkbox[] =>
  // eslint-disable-next-line implicit-arrow-linebreak
  checkboxes.sort((a: Checkbox, b: Checkbox) => alpha(a.label, b.label));

export const QuickCreate = ({
  placeholder,
  name,
  id,
  label,
  checkboxes: checkboxProps,
  formProps,
}: Props) => {
  const [checkboxes, setCheckboxes] = useState(checkboxProps);
  const [open, setOpen] = useState(false);
  const [accordionOpen, setAccordionOpen] = useState(
    checkboxes.some((cb) => cb.checked)
  );
  const [tagKey, setTagKey] = useState();
  const [modalKey, setModalKey] = useState();
  const [body, setBody] = useState();

  const getCheckboxes = () => {
    const checkboxesProp = [];
    checkboxes.forEach((checkbox: Checkbox) => {
      const checkboxProp = {
        id: checkbox.id,
        label: checkbox.label,
        value: checkbox.value,
        checked: checkbox.checked,
      };
      checkboxesProp.push(checkboxProp);
    });
    return checkboxesProp;
  };

  const labelExists = (compareLabel: string) =>
    checkboxes.filter(
      (checkbox: Checkbox) =>
        checkbox.label.toLowerCase() === compareLabel.toLowerCase()
    ).length;

  const addToCheckboxes = ({
    name: newName,
    id: newId,
    slug: newSlug,
  }: {
    name: string,
    id: string,
    slug: string,
  }) => {
    const newCheckboxes = checkboxes.slice(0);
    newCheckboxes.push({
      id: newSlug,
      label: newName,
      value: newId,
      checked: true,
    });
    return sortAlpha(newCheckboxes);
  };

  const onSubmit = (response: any) => {
    const { data } = response;
    if (data && data.success) {
      setOpen(false);
      setAccordionOpen(true);
      setTagKey(Utils.randomString());
      setModalKey(Utils.randomString);
      setCheckboxes(addToCheckboxes(data));
    }
  };

  const displayQuickCreateForm = (nameValue: string) => (
    <DynamicForm
      nameValue={nameValue}
      formProps={formProps}
      onSubmit={onSubmit}
    />
  );

  const onChange = ({
    label: onChangeLabel,
    checkboxes: changeCheckboxes,
  }: {
    label: string,
    checkboxes: Checkbox[],
  }) => {
    if (!labelExists(onChangeLabel)) {
      setOpen(true);
      setModalKey(Utils.randomString());
      setBody(displayQuickCreateForm(onChangeLabel));
      setCheckboxes(sortAlpha(changeCheckboxes));
    }
  };

  return (
    <div>
      <Input
        id={id}
        type="tag"
        name={name}
        label={label}
        checkboxes={getCheckboxes()}
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
