// @flow
import React from 'react';
import axios from 'axios';
import { Form } from './index';

export type Props = {
  nameValue?: string,
  formProps: any,
  onCreate: Function,
};

export type State = {
  formProps: any,
};

export class DynamicForm extends React.Component<Props, State> {
  myRef: any;

  constructor(props: Props) {
    super(props);
    this.state = { formProps: this.processFormProps() };
  }

  processFormProps = () => {
    const { nameValue, formProps } = this.props;
    const processedFormProps = Object.assign({}, formProps);
    if (nameValue) {
      processedFormProps.inputs[0].value = nameValue;
    }
    return processedFormProps;
  };

  getParams = () => {
    const params = {};
    const inputs = Array.from(this.myRef.querySelectorAll('input'));
    const selects = Array.from(this.myRef.querySelectorAll('select'));
    inputs.concat(selects).forEach((input: any) => {
      if (input.id !== 'submit') {
        // Assumes name is in model[column] format
        const indexOfFirstBracket = input.name.indexOf('[');
        const model = input.name.substring(0, indexOfFirstBracket);
        const column = input.name.substring(
          indexOfFirstBracket + 1,
          input.name.length - 1,
        );
        if (!params[model]) {
          params[model] = {};
        }
        params[model][column] = input.value;
      }
    });
    return params;
  };

  onSubmit = () => {
    const { formProps } = this.state;
    axios.post(formProps.action, this.getParams()).then((response: any) => {
      const { onCreate } = this.props;
      if (onCreate) {
        onCreate(response);
      }
    });
  };

  render() {
    const { formProps } = this.state;
    return (
      <Form
        inputs={formProps.inputs}
        noFormTag={formProps.noFormTag}
        noFormTagSubmit={this.onSubmit}
        noFormTagRef={(element) => {
          this.myRef = element;
        }}
      />
    );
  }
}
