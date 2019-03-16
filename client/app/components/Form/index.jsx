// @flow
import React from 'react';
import { Input } from '../Input';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import type { Props as InputProps } from '../Input/utils';
import { REQUIRES_DEFAULT } from '../Input/InputDefault';
import { QuickCreate } from '../../widgets/QuickCreate';
import type { Props as QuickCreateProps } from '../../widgets/QuickCreate';
import { Utils } from '../../utils';
import css from './Form.scss';

type KeyProps = { myKey?: any };

type MyInputProps = InputProps & KeyProps;

type Errors = { [string]: boolean } | {};

export type Props = {
  action?: string,
  inputs: any[],
  noFormTag?: boolean, // Can't have nested forms i.e. quick create
  noFormTagSubmit?: Function,
  noFormTagRef?: any,
};

export type State = {
  inputs: any[],
  errors: Errors,
};

export const hasErrors = (errors: Errors) => Object.values(errors).filter(key => key).length;

export class Form extends React.Component<Props, State> {
  myRefs: Object;

  constructor(props: Props) {
    super(props);
    const inputs = props.inputs.filter((input: any) => input !== {});
    this.state = { inputs, errors: {} };
    this.myRefs = {};
  }

  handleError = (id: string, error: boolean) => {
    const { errors } = this.state;
    const newErrors = Object.assign({}, errors);
    newErrors[id] = error;
    this.setState({ errors: newErrors });
  };

  isInputError = (input: any) => {
    const validType = REQUIRES_DEFAULT.includes(input.type) || input.type === 'textarea';
    return (
      validType
      && input.required
      && this.myRefs[input.id]
      && !this.myRefs[input.id].value
    );
  };

  onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    // Get errors from inputs that were never focused
    const { inputs, errors } = this.state;
    const newErrors = Object.assign({}, errors);
    const newInputs = inputs.map((input: any) => {
      const newInput = Object.assign({}, input);
      if (this.isInputError(newInput)) {
        newInput.error = true;
        newInput.value = this.myRefs[input.id].value;
        newInput.myKey = Utils.randomString(); // Triggers state change in child component
        newErrors[newInput.id] = true;
      }
      return newInput;
    });
    const { noFormTagSubmit } = this.props;
    if (hasErrors(newErrors) > 0) {
      e.preventDefault();
      this.setState({ inputs: newInputs, errors: newErrors });
    } else if (noFormTagSubmit) {
      noFormTagSubmit();
    }
  };

  handleNoFormTagSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    this.onSubmit(e);
  };

  displayInput = (input: MyInputProps) => {
    const { noFormTag } = this.props;
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

  displayQuickCreate = (input: QuickCreateProps) => {
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

  displayInputs = (): any => {
    const { inputs } = this.state;
    return inputs.map((input: any) => {
      if (INPUT_TYPES.includes(input.type)) {
        return this.displayInput(input);
      }
      if (input.type === 'quickCreate') {
        return this.displayQuickCreate(input);
      }
      return null;
    });
  };

  render() {
    const { action, noFormTag, noFormTagRef } = this.props;
    if (noFormTag) {
      return (
        <div className={css.form} ref={noFormTagRef}>
          {this.displayInputs()}
        </div>
      );
    }
    if (!action) return null;
    return (
      <form
        onSubmit={this.onSubmit}
        acceptCharset="UTF-8"
        className={css.form}
        method="post"
        action={action}
      >
        {this.displayInputs()}
      </form>
    );
  }
}
