// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { InputTextarea } from 'components/Input/InputTextarea';
import { InputTextareaTemplate } from 'components/Input/InputTextareaTemplate';
import { InputLabel } from 'components/Input/InputLabel';
import { InputError } from 'components/Input/InputError';
import { InputSubmit } from 'components/Input/InputSubmit';
import { InputCheckbox } from 'components/Input/InputCheckbox';
import { InputCheckboxGroup } from 'components/Input/InputCheckboxGroup';
import { InputPassword } from 'components/Input/InputPassword';
import { InputSelect } from 'components/Input/InputSelect';
import { InputRadioGroup } from 'components/Input/InputRadioGroup';
import { InputTag } from 'components/Input/InputTag';
import { InputSwitch } from 'components/Input/InputSwitch';
import { InputLocation } from 'components/Input/InputLocation';
import { InputDefault, REQUIRES_DEFAULT } from 'components/Input/InputDefault';
import { Accordion } from 'components/Accordion';
import css from './Input.scss';
import { TYPES, REQUIRES_LABEL, REQUIRED_POSSIBLE } from './utils';
import type { Props } from './utils';

export const Input = ({
  id,
  type,
  name,
  info,
  value,
  label,
  ariaLabel,
  placeholder,
  readOnly,
  disabled,
  required,
  minLength,
  maxLength,
  options,
  min,
  max,
  autoComplete,
  myRef,
  dark,
  large,
  small,
  checked,
  checkboxes,
  uncheckedValue,
  formNoValidate,
  accordion,
  accordionOpen,
  googleAPIKey,
  onClick,
  onChange,
  onError,
  copyOnClick,
  error: defaultError,
}: Props): Node => {
  const [error, setError] = useState<boolean>(!!defaultError);

  const hasError = (errorPresent: boolean) => {
    if (onError) {
      onError(id, errorPresent);
    }
    setError(errorPresent);
  };

  const displayDefault = () => {
    if (!REQUIRES_DEFAULT.includes(type)) return null;
    return (
      <InputDefault
        id={id}
        type={type}
        name={name}
        value={value}
        placeholder={placeholder}
        readOnly={readOnly}
        disabled={disabled}
        required={required}
        minLength={minLength}
        maxLength={maxLength}
        min={min}
        max={max}
        autoComplete={autoComplete}
        hasError={(errorPresent: boolean) => hasError(errorPresent)}
        myRef={myRef}
        label={label}
        copyOnClick={copyOnClick}
      />
    );
  };

  const displaySubmit = () => {
    if (type === 'submit' && value) {
      return (
        <InputSubmit
          id={id}
          name={name}
          onClick={onClick}
          value={value}
          large={large}
          small={small}
          dark={dark}
          disabled={disabled}
          formNoValidate={formNoValidate}
        />
      );
    }
    return null;
  };

  const displayTextarea = () => {
    if (type !== 'textarea') return null;
    return (
      <InputTextarea
        value={value}
        id={id}
        name={name}
        required={required}
        hasError={(errorPresent: boolean) => hasError(errorPresent)}
        myRef={myRef}
        dark={dark}
      />
    );
  };

  const displayTextareaTemplate = () => {
    if (type !== 'textareaTemplate') return null;
    return (
      <InputTextareaTemplate
        value={value}
        id={id}
        name={name}
        required={required}
        hasError={(errorPresent: boolean) => hasError(errorPresent)}
        dark={dark}
        options={options}
        myRef={myRef}
      />
    );
  };

  const displayCheckbox = () => {
    if (type === 'checkbox' && typeof value !== 'undefined' && label) {
      return (
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          checked={checked}
          uncheckedValue={uncheckedValue}
          label={label}
          info={info}
          onChange={onChange}
        />
      );
    }
    return null;
  };

  const displayCheckboxGroup = () => {
    if (type === 'checkboxGroup' && checkboxes) {
      return (
        <InputCheckboxGroup
          checkboxes={checkboxes}
          required={required}
          hasError={(errorPresent: boolean) => hasError(errorPresent)}
        />
      );
    }
    return null;
  };

  const displaySelect = () => {
    if (type === 'select' && options) {
      return (
        <InputSelect
          name={name}
          id={id}
          ariaLabel={ariaLabel}
          value={value}
          options={options}
          onChange={onChange}
        />
      );
    }
    return null;
  };

  const displayRadio = () => {
    if (type === 'radio' && options) {
      return (
        <InputRadioGroup name={name} id={id} value={value} options={options} />
      );
    }
    return null;
  };

  const displayTag = () => {
    if (type === 'tag' && checkboxes && name) {
      return (
        <InputTag
          id={id}
          name={name}
          checkboxes={checkboxes}
          placeholder={placeholder}
          onChange={onChange}
        />
      );
    }
    return null;
  };

  const displaySwitch = () => {
    if (type === 'switch' && label && name) {
      return (
        <InputSwitch
          id={id}
          name={name}
          label={label}
          value={value}
          checked={checked}
          uncheckedValue={uncheckedValue}
        />
      );
    }
    return null;
  };

  const displayLabel = () => {
    if (REQUIRES_LABEL.includes(type) && label) {
      return (
        <InputLabel
          label={label}
          required={REQUIRED_POSSIBLE.includes(type) && required}
          info={info}
          error={error}
          htmlFor={id}
        />
      );
    }
    return null;
  };

  const displayLocation = () => {
    if (type === 'location' && googleAPIKey && label) {
      return (
        <InputLocation
          value={value}
          label={label}
          apiKey={googleAPIKey}
          id={id}
          name={name}
        />
      );
    }
    return null;
  };

  const displayPassword = () => {
    if (type === 'password') {
      return (
        <InputPassword
          id={id}
          name={name}
          placeholder={placeholder}
          required={required}
          label={label}
          hasError={(errorPresent: boolean) => hasError(errorPresent)}
        />
      );
    }
    return null;
  };

  const displayError = () => {
    if (error) {
      return <InputError error={error} min={min} max={max} />;
    }
    return null;
  };

  const displayContent = () => (
    <div
      className={`${dark ? css.dark : ''} ${large ? css.large : ''} ${
        small ? css.small : ''
      } ${type === 'hidden' ? css.hidden : ''}`}
    >
      {!accordion && REQUIRES_LABEL.includes(type) && label && (
        <div className={css.labelNoAccordion}>{displayLabel()}</div>
      )}
      {displayDefault()}
      {displayCheckbox()}
      {displayCheckboxGroup()}
      {displayPassword()}
      {displaySelect()}
      {displayRadio()}
      {displayTextarea()}
      {displayTextareaTemplate()}
      {displayTag()}
      {displaySwitch()}
      {displayLocation()}
      {displaySubmit()}
      {displayError()}
    </div>
  );

  if (!TYPES.includes(type)) return null;

  return accordion && label ? (
    <Accordion
      id={id}
      title={displayLabel()}
      open={accordionOpen}
      dark={dark}
      large={large}
    >
      {displayContent()}
    </Accordion>
  ) : (
    displayContent()
  );
};

export default ({
  id,
  type,
  name,
  info,
  value,
  label,
  ariaLabel,
  placeholder,
  readOnly,
  disabled,
  required,
  minLength,
  maxLength,
  options,
  min,
  max,
  myRef,
  dark,
  large,
  small,
  checked,
  checkboxes,
  uncheckedValue,
  formNoValidate,
  accordion,
  accordionOpen,
  googleAPIKey,
  onClick,
  onChange,
  onError,
  copyOnClick,
  error,
}: Props): Node => (
  <Input
    id={id}
    type={type}
    name={name}
    info={info}
    value={value}
    label={label}
    ariaLabel={ariaLabel}
    placeholder={placeholder}
    readOnly={readOnly}
    disabled={disabled}
    required={required}
    minLength={minLength}
    maxLength={maxLength}
    options={options}
    min={min}
    max={max}
    myRef={myRef}
    dark={dark}
    large={large}
    small={small}
    checked={checked}
    checkboxes={checkboxes}
    uncheckedValue={uncheckedValue}
    formNoValidate={formNoValidate}
    accordion={accordion}
    accordionOpen={accordionOpen}
    googleAPIKey={googleAPIKey}
    onClick={onClick}
    onChange={onChange}
    onError={onError}
    copyOnClick={copyOnClick}
    error={error}
  />
);
