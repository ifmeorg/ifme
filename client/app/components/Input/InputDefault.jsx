// @flow
import React, { Fragment } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import css from './Input.scss';
import 'react-toastify/dist/ReactToastify.css';

export const REQUIRES_DEFAULT = ['text', 'number', 'time', 'date', 'hidden'];
export const DEFAULT_WITH_LABEL = ['text', 'number', 'time', 'date'];

export type Props = {
  id: string,
  type: string,
  name?: string,
  value?: any,
  placeholder?: string,
  readOnly?: boolean,
  disabled?: boolean,
  required?: boolean,
  minLength?: number,
  maxLength?: number,
  min?: number,
  max?: number,
  hasError?: Function,
  myRef?: any,
  label?: string,
  onClick?: Function,
  copyOnClick?: boolean,
};

const copyToClipBoard = (e: SyntheticEvent<HTMLInputElement>) => {
  e.currentTarget.select();
  document.execCommand('copy');
  // TODO: Once i18n and react are playing nicely this can be changed
  toast('Secret Share Link Copied!', { autoClose: 5000 });
};

const onFocus = (required: ?boolean, hasError: ?Function) => {
  if (required && hasError) {
    hasError(false);
  }
};

const onBlur = (
  e: SyntheticEvent<HTMLInputElement>,
  required: ?boolean,
  hasError: ?Function,
) => {
  const { value } = e.currentTarget;
  if (required && hasError) {
    hasError(!value);
  }
};

export const InputDefault = (props: Props) => {
  const {
    id,
    type,
    name,
    placeholder,
    readOnly,
    disabled,
    required,
    minLength,
    maxLength,
    min,
    max,
    value,
    hasError,
    myRef,
    label,
    copyOnClick,
  } = props;
  if (!REQUIRES_DEFAULT.includes(type)) return null;
  return (
    <Fragment>
      <input
        className={css.default}
        id={id}
        type={type}
        name={name}
        defaultValue={value}
        placeholder={placeholder}
        readOnly={readOnly}
        disabled={disabled}
        required={required}
        minLength={minLength}
        maxLength={maxLength}
        min={min}
        max={max}
        onFocus={() => onFocus(required, hasError)}
        onBlur={(e: SyntheticEvent<HTMLInputElement>) => onBlur(e, required, hasError)
        }
        ref={myRef}
        aria-label={label}
        aria-invalid={hasError}
        onClick={copyOnClick ? (e: SyntheticEvent<HTMLInputElement>) => { copyToClipBoard(e); }
          : () => {}}
      />
      <ToastContainer />
    </Fragment>
  );
};
