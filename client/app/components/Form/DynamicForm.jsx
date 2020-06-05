// @flow
import React, { useState } from 'react';
import axios from 'axios';
import Input from '../Input';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps } from './utils';

export type Props = {
  nameValue?: string, // This is just for QuickCreate
  formProps: FormProps,
  onSubmit: Function,
  type?: 'post' | 'patch',
};

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

const getInputsInitialState = (
  formProps: FormProps,
  nameValue?: string,
): MyInputProps[] => {
  const formInputs = formProps.inputs.filter(
    (input: MyInputProps) => input !== {},
  );
  if (nameValue) {
    formInputs[0].value = nameValue;
  }
  return formInputs;
};

// TODO: Long-term, we should have React (instead of Rails) handle form submissions
// so that we don't have to do this.
const getParams = (inputs: MyInputProps[], myRefs: Object) => {
  const params = {};
  inputs.forEach((input: MyInputProps) => {
    const { name, id } = input;
    if (id !== 'submit') {
      // Assumes name is in model[column] format
      const indexOfFirstBracket = name.indexOf('[');
      const model = name.substring(0, indexOfFirstBracket);
      const column = name.substring(indexOfFirstBracket + 1, name.length - 1);
      if (!params[model]) {
        params[model] = {};
      }
      params[model][column] = myRefs[id] && myRefs[id].value;
    }
  });
  return params;
};

export const hasErrors = (errors: Errors) => Object.values(errors).filter((key) => key).length;

export const DynamicForm = ({
  nameValue,
  formProps,
  onSubmit,
  type,
}: Props) => {
  const [inputs, setInputs] = useState<MyInputProps[]>(
    getInputsInitialState(formProps, nameValue),
  );
  const [errors, setErrors] = useState<Errors>({});

  const myRefs: Object = {};

  const handleError = (id: string, error: boolean) => {
    const newErrors = { ...errors };
    newErrors[id] = error;
    setErrors(newErrors);
  };

  const onHandleSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    // Get errors from inputs that were never focused
    const { inputs: newInputs, errors: newErrors } = getNewInputs({
      inputs,
      errors,
      refs: myRefs,
    });
    if (hasErrors(newErrors) > 0) {
      setInputs(newInputs);
      setErrors(newErrors);
    } else {
      axios[type || 'post'](formProps.action, getParams(inputs, myRefs)).then(
        (response: Object) => {
          if (onSubmit) {
            onSubmit(response);
          }
        },
      );
      // TODO: Actually handle errors through catch()
    }
  };

  const displayInput = (input: MyInputProps) => (
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
        minLength={input.minLength}
        maxLength={input.maxLength}
        dark={input.dark}
        large={input.large}
        checked={input.checked}
        uncheckedValue={input.uncheckedValue}
        options={input.options}
        checkboxes={input.checkboxes}
        accordion={input.accordion}
        onClick={input.type === 'submit' ? onHandleSubmit : undefined}
        onError={input.type !== 'submit' ? handleError : undefined}
        myRef={(element) => {
          myRefs[input.id] = element;
        }}
        formNoValidate={input.type === 'submit'}
      />
    </div>
  );

  const displayInputs = () => inputs.map((input: MyInputProps) => {
    if (INPUT_TYPES.includes(input.type)) {
      return displayInput(input);
    }
    return null;
  });

  return <div className={css.form}>{displayInputs()}</div>;
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({
  nameValue, formProps, onSubmit, type,
}: Props) => (
  <DynamicForm
    nameValue={nameValue}
    formProps={formProps}
    onSubmit={onSubmit}
    type={type}
  />
);
