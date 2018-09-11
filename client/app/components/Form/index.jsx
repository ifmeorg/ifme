// @flow
import React from 'react';
import { Input } from '../Input';
import type { Props as InputProps } from '../Input';
import css from './Form.scss';

export type Props = {
  inputs: InputProps[],
};

export type State = {
  inputs: InputProps[],
  errors: { [string]: boolean } | {},
};

export class Form extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { inputs: props.inputs, errors: {} };
  }

  handleError = (id: string, error: boolean) => {
    const { errors } = this.state;
    const newErrors = Object.assign({}, errors);
    newErrors[id] = error;
    this.setState({ errors: newErrors });
  };

  clickSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    const { errors } = this.state;
    const numErrors = Object.values(errors).filter(key => key).length;
    if (numErrors > 0) {
      e.preventDefault();
    }
  };

  displayInput = (input: InputProps) => (
    <Input
      id={input.id}
      type={input.type}
      name={input.name}
      label={input.label}
      placeholder={input.placeholder}
      error={input.error}
      value={input.value}
      readOnly={input.readOnly}
      disabled={input.disabled}
      required={input.required}
      info={input.info}
      minLength={input.minLength}
      maxLength={input.maxLength}
      dark={input.dark}
      large={input.large}
      key={input.id}
      checked={input.checked}
      uncheckedValue={input.uncheckedValue}
      options={input.options}
      checkboxes={input.checkboxes}
      onClick={input.type === 'submit' ? this.clickSubmit : undefined}
      onError={input.type !== 'submit' ? this.handleError : undefined}
    />
  );

  render() {
    const { inputs } = this.state;
    return (
      <div className={css.form}>
        {inputs.map((input: InputProps) => this.displayInput(input))}
      </div>
    );
  }
}
