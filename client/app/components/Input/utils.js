// @flow
import { REQUIRES_DEFAULT, DEFAULT_WITH_LABEL } from './InputDefault';

export const TYPES = REQUIRES_DEFAULT.concat([
  'textarea',
  'submit',
  'checkbox',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
  'location',
]);

export const REQUIRES_LABEL = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
]);

export const REQUIRED_POSSIBLE = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'checkboxGroup',
]);

export type Option = {
  id: string,
  value: any,
  label: string,
};

export type Checkbox = {
  id: string,
  name?: string,
  value: any,
  checked?: boolean,
  uncheckedValue?: any,
  label: string,
  onChange?: Function,
  info?: string,
};

export type Props = {
  id: string,
  type: | 'text'
    | 'textarea'
    | 'submit'
    | 'checkbox'
    | 'number'
    | 'time'
    | 'date'
    | 'select'
    | 'checkboxGroup'
    | 'tag'
    | 'hidden'
    | 'switch'
    | 'location',
  name?: string,
  label?: string,
  placeholder?: string,
  error?: boolean,
  dark?: boolean,
  small?: boolean,
  large?: boolean,
  value?: any,
  ariaLabel?: string,
  readOnly?: boolean,
  disabled?: boolean,
  required?: boolean,
  info?: string,
  minLength?: number,
  maxLength?: number,
  onClick?: Function,
  onChange?: Function,
  checked?: boolean,
  uncheckedValue?: any,
  min?: number,
  max?: number,
  options?: Option[],
  checkboxes?: Checkbox[],
  onError?: Function,
  accordion?: boolean,
  myRef?: any,
  accordionOpen?: boolean,
  formNoValidate?: boolean,
  googleAPIKey?: string,
};

export type State = {
  error: boolean,
};
