// @flow
import React from 'react';
import { Input } from '../../components/Input';
import { TYPES as INPUT_TYPES } from '../../components/Input/utils';
import type { State } from '../../components/Input/utils';
import type { Props as InputProps } from '../../components/Input/utils';
import { displayQuickCreate } from '../../components/Form/quickCreate';


type KeyProps = { myKey?: any };
type MyInputProps = InputProps & KeyProps;

type DisplayInputType = {
    noFormTag: boolean,
}

type InputState = {
  inputs: State
};
export type Props ={
  inputs: any[],
  noFormTag?: boolean, // Can't have nested forms i.e. quick create
}

const displayInput = ({input: MyInputProps, noFormTag: input}) => {
    const { noFormTag } = input;
    return (
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
          onClick={
            input.type === 'submit' && noFormTag
              ? this.handleNoFormTagSubmit
              : undefined
          }
          onError={input.type !== 'submit' ? this.handleError : undefined}
          myRef={(element) => {
            this.myRefs[input.id] = element;
          }}
          formNoValidate={input.type === 'submit'}
        />
      </div>
    );
  };

export const displayInputs = ({inputs: InputState}) => {
    const { inputs } = InputState;
    return inputs.map((input: any) => {
      if (INPUT_TYPES.includes(input.type)) {
        return displayInput(input);
      }
      if (input.type === 'quickCreate') {
        return displayQuickCreate(input);
      }
      return null;
    });
  };
