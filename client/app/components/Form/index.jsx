// @flow
/* eslint-disable max-len */
/* eslint-disable no-unused-vars */
import React, { useState, type Node } from 'react';
import Input from 'components/Input';
import { TYPES as INPUT_TYPES } from 'components/Input/utils';
import { QuickCreate } from 'widgets/QuickCreate';
import type { Props as QuickCreateProps } from 'widgets/QuickCreate';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps as Props } from './utils';

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

const getInputsInitialState = (inputs: MyInputProps[]) => inputs.filter((input) => input !== {});

export const Form = ({ action, inputs: inputsProps }: Props): Node => {
  const [inputs, setInputs] = useState<MyInputProps[]>(
    getInputsInitialState(inputsProps),
  );
  const [errors, setErrors] = useState<Errors>({});

  const myRefs: Object = {};

  const handleError = (id: string, error: boolean): void => {
    const newErrors = { ...errors };
    newErrors[id] = error;
    setErrors(newErrors);
  };

  const onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    // Get errors from inputs that were never focused
    const { inputs: newInputs, errors: newErrors } = getNewInputs({
      inputs,
      errors,
      refs: myRefs,
    });
    const onlyErrors = Object.entries(newErrors).filter(
      ([key, value]) => value,
    );

    if (onlyErrors.length > 0) {
      e.preventDefault();
      setInputs(newInputs);
      setErrors(newErrors);

      const labelForError = document.querySelector(
        `label[for="${onlyErrors[0][0]}"]`,
      );
      if (labelForError) {
        labelForError.scrollIntoView();
      }
    }
  };

  const displayInput = (input: MyInputProps): Node => (
    <div key={input.id}>
      <Input
        id={input.id}
        key={input.myKey}
        type={input.type}
        name={input.name}
        label={input.label}
        placeholder={input.placeholder}
        error={input.error}
        value={input.value}
        readOnly={input.readOnly}
        copyOnClick={input.copyOnClick}
        disabled={input.disabled}
        required={input.required}
        info={input.info}
        min={input.min}
        max={input.max}
        minLength={input.minLength}
        maxLength={input.maxLength}
        dark={input.dark}
        large={input.large}
        checked={input.checked}
        uncheckedValue={input.uncheckedValue}
        options={input.options}
        checkboxes={input.checkboxes}
        accordion={input.accordion}
        onError={input.type !== 'submit' ? handleError : undefined}
        myRef={(element) => {
          myRefs[input.id] = element;
        }}
        formNoValidate={input.type === 'submit'}
      />
    </div>
  );

  const displayQuickCreate = (input: QuickCreateProps): Node => {
    const {
      id, name, label, placeholder, checkboxes, formProps,
    } = input;
    if (!checkboxes || !name || !label) return null;
    return (
      <div key={id}>
        <QuickCreate
          id={id}
          name={name}
          label={label}
          placeholder={placeholder}
          checkboxes={checkboxes}
          formProps={formProps}
        />
      </div>
    );
  };

  const displayInputs = (): Array<Node | null> => inputs.map((input: any) => {
    if (INPUT_TYPES.includes(input.type)) {
      return displayInput(input);
    }
    if (input.type === 'quickCreate') {
      return displayQuickCreate(input);
    }
    return null;
  });

  if (!action) {
    return null;
  }

  const { form } = css;

  let csrfInput = '';
  const csrfParam = document.querySelector('meta[name="csrf-param"]');
  const csrfToken = document.querySelector('meta[name="csrf-token"]');

  if (csrfParam != null && csrfToken != null) {
    csrfInput = (
      <input
        type="hidden"
        value={csrfToken.getAttribute('content')}
        name={csrfParam.getAttribute('content')}
      />
    );
  }

  return (
    <form
      onSubmit={onSubmit}
      acceptCharset="UTF-8"
      className={form}
      method="post"
      action={action}
    >
      {csrfInput}
      {displayInputs()}
    </form>
  );
};

export default ({ action, inputs }: Props): Node => (
  <Form action={action} inputs={inputs} />
);
