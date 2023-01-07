// @flow
import { Utils } from 'utils';
import { REQUIRES_DEFAULT } from 'components/Input/InputDefault';
import type { Props as InputProps } from 'components/Input/utils';

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
    const validType = REQUIRES_DEFAULT.includes(input.type)
      || input.type === 'textarea'
      || input.type === 'textareaTemplate';
    const element = refs[input.id];

    if (!validType && !element) {
      return false;
    }

    if (
      input.type === 'number'
      && typeof element.value !== 'undefined'
      && !Number.isNaN(parseInt(element.value, 10))
    ) {
      if (typeof input.min === 'number' && typeof input.max === 'number') {
        return (
          // $FlowIgnore[invalid-compare]
          !(parseInt(element.value, 10) >= input.min)
          // $FlowIgnore[invalid-compare]
          || !(parseInt(element.value, 10) <= input.max)
        );
      }
      if (typeof input.min === 'number') {
        // $FlowIgnore[invalid-compare]
        return !(parseInt(element.value, 10) >= input.min);
      }
      if (typeof input.max === 'number') {
        // $FlowIgnore[invalid-compare]
        return !(parseInt(element.value, 10) <= input.max);
      }
    }

    return input.required && !element.value;
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
