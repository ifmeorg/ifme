// @flow
import React from 'react';
import { Input } from '../components/Input';
import type { Props } from '../components/Input';

const inputTextProps = {
  id: 'some-text-id',
  type: 'text',
  name: 'some-text-name',
  label: 'Some Text Label',
  placeholder: 'Some Text Placeholder',
  info: 'Some Text Info',
};

const inputTextareaProps = {
  id: 'some-textarea-id',
  type: 'textarea',
  name: 'some-textarea-name',
  label: 'Some Textarea Label',
  placeholder: 'Some Textarea Placeholder',
};

const inputSelectProps = {
  id: 'some-select-id',
  type: 'select',
  name: 'some-select-name',
  label: 'Some Select Label',
  value: 2,
  options: [{ value: 1, label: 'First' }, { value: 2, label: 'Second' }],
};

const inputCheckboxProps = {
  id: 'some-checkbox-id',
  type: 'checkbox',
  name: 'some-checkbox-name',
  label: 'Some Checkbox Label',
  value: 1,
  checked: true,
  uncheckedValue: 0,
};

const inputCheckboxGroupProps = {
  id: 'some-checkbox-group-id',
  type: 'checkboxGroup',
  name: 'some-checkbox-group-name',
  label: 'Some Checkbox Group Label',
  checkboxes: [
    {
      id: 'some-checkbox-one',
      name: 'some-checkbox-one-name',
      label: 'Some Checkbox One Label',
      value: 1,
      checked: true,
      uncheckedValue: 0,
    },
    {
      id: 'some-checkbox-two',
      name: 'some-checkbox-two-name',
      label: 'Some Checkbox Two Label',
      value: 2,
    },
  ],
};

const inputSubmitProps = {
  id: 'some-submit-id',
  type: 'submit',
  name: 'some-submit-name',
  value: 'Some Submit Value',
};

const event = () => window.alert('Event triggered!');

const createInput = (props: ?Props, extraProps: ?Props) => {
  const inputProps = Object.assign({}, props, extraProps);
  return React.createElement(Input, inputProps);
};

export const InputMocks = {
  inputTextProps,
  inputTextareaProps,
  inputSelectProps,
  inputCheckboxProps,
  inputCheckboxGroupProps,
  inputSubmitProps,
  event,
  createInput,
};
