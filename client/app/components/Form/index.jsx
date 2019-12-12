// @flow
import React from 'react';
import { displayQuickCreate } from './quickCreate';
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

  onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    // Get errors from inputs that were never focused
    const { errors } = this.state;
    const newErrors = { ...errors };
    const { noFormTagSubmit } = this.props;
    if (hasErrors(newErrors) > 0) {
      e.preventDefault();
      this.setState({ errors: newErrors });
    } else if (noFormTagSubmit) {
      noFormTagSubmit();
    }
  };

  handleNoFormTagSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    this.onSubmit(e);
  };

  displayInputs = (): any => {
    const { inputs } = this.state;
    return inputs.map((input: any) => {
      if (input.type === 'quickCreate') {
        return displayQuickCreate(input);
      }
      return null;
    });
  };

  render() {
    const { action, noFormTag, noFormTagRef } = this.props;
    if (noFormTag) {
      // This will go into Dynamic Form
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
