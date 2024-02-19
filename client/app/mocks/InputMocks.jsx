// @flow
import React from 'react';
import type { Node } from 'react';
import { Input } from 'components/Input';
import type { Props } from 'components/Input/utils';

const options = [
  { id: 'some-option-one-id', value: 1, label: 'Some Option One' },
  { id: 'some-option-two-id', value: 2, label: 'Some Option Two' },
];

const checkboxes = [
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
];

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
  info: 'Some Textarea Info',
};

const inputTextareaTemplateProps = {
  id: 'some-textarea-template-id',
  type: 'textareaTemplate',
  name: 'some-textarea-template-name',
  label: 'Some Textarea Template Label',
  placeholder: 'Some Textarea Template Placeholder',
  info: 'Some Textarea Template Info',
  options,
};

const inputSelectProps = {
  id: 'some-select-id',
  type: 'select',
  ariaLabel: 'some-select-label',
  name: 'some-select-name',
  label: 'Some Select Label',
  value: 2,
  options,
};

const inputMultiSelectProps = {
  type: 'multiSelect',
  ariaLabel: 'some-select-label',
  id: 'some-select-id',
  label: 'some-select-arialabel',
  name: 'some-select-label',
  options,
};

const inputRadioProps = {
  id: 'some-radio-id',
  type: 'radio',
  name: 'some-radio-name',
  label: 'Some Radio Label',
  value: 1,
  options,
};

const inputPasswordProps = {
  id: 'some-password-id',
  type: 'password',
  name: 'some-password-name',
  label: 'Some Password Label',
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
  checkboxes,
};

const inputTagProps = {
  id: 'some-tag-id',
  type: 'tag',
  name: 'some-tag-name',
  label: 'Some Tag Label',
  info: 'Some Tag Info',
  placeholder: 'Some Tag Placeholder',
  checkboxes,
};

const inputSwitchProps = {
  id: 'some-switch-id',
  type: 'switch',
  name: 'some-switch-name',
  label: 'Some Switch Label',
  info: 'Some Switch Info',
  value: true,
  uncheckedValue: false,
};

const inputNumberProps = {
  id: 'some-number-id',
  type: 'number',
  name: 'some-number-name',
  label: 'Some Number Label',
  min: 0,
  max: 2,
};

const inputSubmitProps = {
  id: 'some-submit-id',
  type: 'submit',
  name: 'some-submit-name',
  value: 'Some Submit Value',
};

const event = (): void => window.alert('Event triggered!');

const createInput = (props: Props, extraProps: any): Node => {
  const inputProps = { ...props, ...extraProps };
  return React.createElement(Input, inputProps);
};

export const InputMocks = {
  inputTextProps,
  inputTextareaProps,
  inputTextareaTemplateProps,
  inputSelectProps,
  inputMultiSelectProps,
  inputRadioProps,
  inputCheckboxProps,
  inputCheckboxGroupProps,
  inputSubmitProps,
  inputTagProps,
  inputSwitchProps,
  inputPasswordProps,
  inputNumberProps,
  event,
  createInput,
};
