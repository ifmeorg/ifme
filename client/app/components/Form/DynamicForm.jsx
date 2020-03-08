// @flow
import React from 'react';
import axios from 'axios';
import { Input } from '../Input';
import { TYPES as INPUT_TYPES } from '../Input/utils';
import css from './Form.scss';
import { getNewInputs } from './utils';
import type { Errors, MyInputProps, FormProps } from './utils';

export type Props = {
  nameValue?: string, // This is just for QuickCreate
  formProps: FormProps,
  onCreate: Function,
};

export type State = {
  inputs: MyInputProps[],
  errors: Errors,
};

export const hasErrors = (errors: Errors) => Object.values(errors).filter((key) => key).length;

export class DynamicForm extends React.Component<Props, State> {
  myRefs: Object;

  constructor(props: Props) {
    super(props);
    const { formProps, nameValue } = props;
    const inputs = formProps.inputs.filter(
      (input: MyInputProps) => input !== {},
    );
    if (nameValue) {
      inputs[0].value = nameValue;
    }
    this.state = { inputs, errors: {} };
    this.myRefs = {};
  }

  handleError = (id: string, error: boolean) => {
    const { errors } = this.state;
    const newErrors = { ...errors };
    newErrors[id] = error;
    this.setState({ errors: newErrors });
  };

  // TODO: Long-term, we should have React (instead of Rails) handle form submissions
  // so that we don't have to do this.
  getParams = () => {
    const { inputs } = this.state;
    const params = {};
    // TODO: replace any with actual type
    inputs.forEach((input: any) => {
      const { name, id } = input;
      if (id !== 'submit') {
        // Assumes name is in model[column] format
        const indexOfFirstBracket = name.indexOf('[');
        const model = name.substring(0, indexOfFirstBracket);
        const column = name.substring(indexOfFirstBracket + 1, name.length - 1);
        if (!params[model]) {
          params[model] = {};
        }
        params[model][column] = this.myRefs[id] && this.myRefs[id].value;
      }
    });
    return params;
  };

  onSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    // Get errors from inputs that were never focused
    const { inputs, errors } = this.state;
    const { inputs: newInputs, errors: newErrors } = getNewInputs({
      inputs,
      errors,
      refs: this.myRefs,
    });
    if (hasErrors(newErrors) > 0) {
      this.setState({ inputs: newInputs, errors: newErrors });
    } else {
      const { formProps, onCreate } = this.props;
      axios.post(formProps.action, this.getParams()).then((response: any) => {
        if (onCreate) {
          onCreate(response);
        }
      });
      // TODO: Actually handle errors through catch()
    }
  };

  displayInput = (input: MyInputProps) => (
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
        onClick={input.type === 'submit' ? this.onSubmit : undefined}
        onError={input.type !== 'submit' ? this.handleError : undefined}
        myRef={(element) => {
          this.myRefs[input.id] = element;
        }}
        formNoValidate={input.type === 'submit'}
      />
    </div>
  );

  displayInputs = (): any => {
    const { inputs } = this.state;
    return inputs.map((input: MyInputProps) => {
      if (INPUT_TYPES.includes(input.type)) {
        return this.displayInput(input);
      }
      return null;
    });
  };

  render() {
    return <div className={css.form}>{this.displayInputs()}</div>;
  }
}
