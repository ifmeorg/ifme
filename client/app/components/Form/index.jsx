// @flow
import React, { useState, type Node } from 'react';
import Input from '../Input';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import { QuickCreate } from '../../widgets/QuickCreate';
import type { Props as QuickCreateProps } from '../../widgets/QuickCreate';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps as Props } from './utils';

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

export const hasErrors = (errors: Errors) => Object.values(errors).filter((key) => key).length;

const getInputsInitialState = (inputs: MyInputProps[]) => inputs.filter((input) => input !== {});

export const Form = ({ action, inputs: inputsProps }: Props) => {
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
    if (hasErrors(newErrors) > 0) {
      e.preventDefault();
      setInputs(newInputs);
      setErrors(newErrors);
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
  return (
    <form
      onSubmit={onSubmit}
      acceptCharset="UTF-8"
      className={form}
      method="post"
      action={action}
    >
      {displayInputs()}
    </form>
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({ action, inputs }: Props) => (
  <Form action={action} inputs={inputs} />
);
