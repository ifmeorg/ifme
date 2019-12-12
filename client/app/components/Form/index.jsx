// @flow
import React from 'react';
import { REQUIRES_DEFAULT } from '../Input/InputDefault';
import { displayQuickCreate } from './quickCreate';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import { FormInputs } from './FormInputs';
import { Utils } from '../../utils';
import css from './Form.scss';


type Errors = { [string]: boolean } | {};

export type Props = {
  action?: string,
  inputs: any[],
  noFormTagSubmit?: Function,
  noFormTag?: boolean, // Can't have nested forms i.e. quick create
  noFormTagRef?: any,
};

export type State = {
  inputs: any[],
  errors: Errors,
};

export const hasErrors = (errors: Errors) => Object.values(errors).filter((key) => key).length;

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
  const newErrors = { ...errors };
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
    const newErrors = { ...errors };
    const newInputs = inputs.map((input: any) => {
      const newInput = { ...input };
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



  render() {
    const { action, noFormTag, noFormTagRef } = this.props;
    if (noFormTag) {
      // This will go into Dynamic Form
      return (
        <div className={css.form} ref={noFormTagRef}>
         <FormInputs />
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
       <FormInputs />
      </form>
    );
  }
}
