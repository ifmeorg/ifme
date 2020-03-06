// @flow
import React, { useState, type Node } from 'react';
import { Input } from '../Input';
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

function getInputsInitialState(props: Props): MyInputProps[] {
  return props.inputs.filter((input: MyInputProps) => input !== {});
}

export function Form(props: Props) {
  const [inputs, setInputs] = useState<MyInputProps[]>(
    getInputsInitialState(props),
  );
  const [errors, setErrors] = useState<Errors>({});

  const myRefs: Object = {};

  const handleError = (id: string, error: boolean): void => {
    const newErrors = { ...errors };
    newErrors[id] = error;
    setErrors(newErrors);
  };

  const isInputError = (input: any): boolean => {
    const validType = REQUIRES_DEFAULT.includes(input.type) || input.type === 'textarea';
    return (
      validType && input.required && myRefs[input.id] && !myRefs[input.id].value
    );
  };

  const onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    // Get errors from inputs that were never focused
    const newErrors = { ...errors };
    const newInputs = inputs.map((input: MyInputProps) => {
      const newInput: MyInputProps = { ...input };
      if (isInputError(newInput)) {
        newInput.error = true;
        newInput.value = myRefs[input.id].value;
        newInput.myKey = Utils.randomString(); // Triggers state change in child component
        newErrors[newInput.id] = true;
      }
      return newInput;
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

  const renderForm = (): Node => {
    // action prop destructuring fails due to unresolved eslint-plugin-react issue
    // eslint-disable-next-line
    const { action } = props;
    const { form } = css;

    if (!action) {
      return null;
    }
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

  return renderForm();
}
