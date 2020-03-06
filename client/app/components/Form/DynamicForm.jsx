// @flow
import React, { useState, type Node } from 'react';
import axios from 'axios';
import { Input } from '../Input';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps } from './utils';

export type Props = {
  // Somehow Flow does not detect nameValue being used in a function outside the component
  // eslint-disable-next-line react/no-unused-prop-types
  nameValue?: string, // This is just for QuickCreate
  formProps: FormProps,
  onCreate: Function,
};

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

function getInputsInitialState(props: Props): MyInputProps[] {
  const { formProps, nameValue } = props;
  const formInputs = formProps.inputs.filter(
    (input: MyInputProps) => input !== {},
  );
  if (nameValue) {
    formInputs[0].value = nameValue;
  }
  return formInputs;
}

export const hasErrors = (errors: Errors) => Object.values(errors).filter((key) => key).length;

export function DynamicForm(props: Props) {
  const [inputs, setInputs] = useState<MyInputProps[]>(
    getInputsInitialState(props),
  );
  const [errors, setErrors] = useState<Errors>({});

  const myRefs: Object = {};

  const handleError = (id: string, error: boolean) => {
    const newErrors = { ...errors };
    newErrors[id] = error;
    setErrors(newErrors);
  };

  const isInputError = (input: MyInputProps) => {
    const validType = REQUIRES_DEFAULT.includes(input.type) || input.type === 'textarea';
    return (
      validType && input.required && myRefs[input.id] && !myRefs[input.id].value
    );
  };

  // TODO: Long-term, we should have React (instead of Rails) handle form submissions
  // so that we don't have to do this.
  const getParams = () => {
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

  const onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
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
      setInputs(newInputs);
      setErrors(newErrors);
    } else {
      const { formProps, onCreate } = props;
      axios.post(formProps.action, getParams()).then((response: any) => {
        if (onCreate) {
          onCreate(response);
        }
      });
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
        onClick={input.type === 'submit' ? onSubmit : undefined}
        onError={input.type !== 'submit' ? handleError : undefined}
        myRef={(element) => {
          myRefs[input.id] = element;
        }}
        formNoValidate={input.type === 'submit'}
      />
    </div>
  );

  const displayInputs = (): Array<Node | null> => inputs.map((input: MyInputProps) => {
    if (INPUT_TYPES.includes(input.type)) {
      return displayInput(input);
    }
    return null;
  });

  return <div className={css.form}>{displayInputs()}</div>;
}
