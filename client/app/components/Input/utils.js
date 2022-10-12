// @flow
import {
  REQUIRES_DEFAULT,
  DEFAULT_WITH_LABEL,
} from 'components/Input/InputDefault';

export const TYPES: string[] = REQUIRES_DEFAULT.concat([
  'textarea',
  'submit',
  'checkbox',
  'radio',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
  'password',
  'location',
  'textareaTemplate',
]);

export const REQUIRES_LABEL: string[] = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'select',
  'checkboxGroup',
  'radio',
  'tag',
  'switch',
  'password',
  'location',
  'textareaTemplate',
]);

export const REQUIRED_POSSIBLE: string[] = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'radio',
  'checkboxGroup',
  'password',
  'location',
  'textareaTemplate',
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
    | 'radio'
    | 'number'
    | 'time'
    | 'date'
    | 'select'
    | 'checkboxGroup'
    | 'tag'
    | 'hidden'
    | 'switch'
    | 'location'
    | 'password'
    | 'email'
    | 'search'
    | 'quickCreate'
    | 'tel'
    | 'textareaTemplate',
  name: string,
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
  autoComplete?: 'on' | 'off',
  options?: Option[],
  checkboxes?: Checkbox[],
  onError?: Function,
  accordion?: boolean,
  myRef?: any,
  accordionOpen?: boolean,
  formNoValidate?: boolean,
  googleAPIKey?: string,
  copyOnClick?: string,
};

/* eslint no-param-reassign: ["error", { "props": false }] */
export const mergeRefs = (...refs: any): Function => (
  element: HTMLInputElement,
): Function => {
  refs.forEach((ref) => {
    if (typeof ref === 'function') {
      ref(element);
    } else if (ref) {
      ref.current = element;
    }
  });
};
