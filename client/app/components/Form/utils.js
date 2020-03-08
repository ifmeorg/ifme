// @flow
import { REQUIRES_DEFAULT } from '../Input/InputDefault';
import { Utils } from '../../utils';
import type { Props as InputProps } from '../Input/utils';

type KeyProps = { myKey?: string };

export type MyInputProps = InputProps & KeyProps;

export type FormProps = {
  action?: string,
  inputs: MyInputProps[],
};

export type Errors = { [string]: boolean } | {};

type GetNewInputsArgs = {
  inputs: MyInputProps[],
  refs: Object,
  errors: Errors,
};

type GetNewInputsReturn = {
  inputs: MyInputProps[],
  errors: Errors,
};

export const getNewInputs = ({
  inputs,
  refs,
  errors,
}: GetNewInputsArgs): GetNewInputsReturn => {
  const isInputError = (input: MyInputProps) => {
    const validType = REQUIRES_DEFAULT.includes(input.type) || input.type === 'textarea';
    return (
      validType && input.required && refs[input.id] && !refs[input.id].value
    );
  };

  const newErrors: Errors = { ...errors };
  const newInputs = inputs.map((input: MyInputProps) => {
    const newInput: MyInputProps = { ...input };
    if (isInputError(newInput)) {
      newInput.error = true;
      newInput.value = refs[input.id].value;
      newInput.myKey = Utils.randomString(); // Triggers state change in child component
      newErrors[newInput.id] = true;
    }
    return newInput;
  });

  return { inputs: newInputs, errors: newErrors };
};
