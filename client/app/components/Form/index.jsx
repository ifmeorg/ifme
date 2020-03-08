// @flow
import React from 'react';
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

export class Form extends React.Component<Props, State> {
  myRefs: Object;

  constructor(props: Props) {
    super(props);
    const inputs = props.inputs.filter((input: MyInputProps) => input !== {});
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
    const { inputs, errors } = this.state;
    const { inputs: newInputs, errors: newErrors } = getNewInputs({
      inputs,
      errors,
      refs: this.myRefs,
    });
    if (hasErrors(newErrors) > 0) {
      e.preventDefault();
      this.setState({ inputs: newInputs, errors: newErrors });
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
        onError={input.type !== 'submit' ? this.handleError : undefined}
        myRef={(element) => {
          this.myRefs[input.id] = element;
        }}
        formNoValidate={input.type === 'submit'}
      />
    </div>
  );

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
    // TODO: replace any with actual type
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
    const { action } = this.props;
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
