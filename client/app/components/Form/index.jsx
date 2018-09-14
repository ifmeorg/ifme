// @flow
import React from 'react';
import { Input } from '../Input';
import type { Props as InputProps } from '../Input';
import { REQUIRES_DEFAULT } from '../Input/InputDefault';
import css from './Form.scss';

type FormInput = InputProps | Object;

export type Props = {
  inputs: FormInput[],
};

export type State = {
  inputs: InputProps[],
  errors: { [string]: boolean } | {},
};

const hasErrors = errors => Object.values(errors).filter(key => key).length;

const randomKey = () => Math.random()
  .toString(36)
  .substring(2, 15)
  + Math.random()
    .toString(36)
    .substring(2, 15);

export class Form extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    const inputs = props.inputs.filter((input: FormInput) => input !== {});
    this.state = { inputs, errors: {} };
  }

  handleError = (id: string, error: boolean) => {
    const { errors } = this.state;
    const newErrors = Object.assign({}, errors);
    newErrors[id] = error;
    this.setState({ errors: newErrors });
  };

  clickSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    // Get errors from inputs that were never focused
    const { inputs, errors } = this.state;
    const newErrors = Object.assign({}, errors);
    const newInputs = inputs.map((input: FormInput) => {
      const newInput = Object.assign({}, input);
      console.log(newInput.type, newInput.value);
      if (
        (REQUIRES_DEFAULT.includes(newInput.type)
          || newInput.type === 'textarea')
        && newInput.required
        && !newInput.value
      ) {
        newInput.error = true;
        newInput.key = randomKey();
        newErrors[newInput.id] = true;
      }
      return newInput;
    });
    if (hasErrors(newErrors) > 0) {
      e.preventDefault();
      this.setState({ inputs: newInputs, errors: newErrors });
    }
  };

  displayInput = (input: InputProps) => (
    <div key={input.id}>
      <Input
        id={input.id}
        key={input.key}
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
        checked={input.checked}
        uncheckedValue={input.uncheckedValue}
        options={input.options}
        checkboxes={input.checkboxes}
        accordion={input.accordion}
        onClick={input.type === 'submit' ? this.clickSubmit : undefined}
        onError={input.type !== 'submit' ? this.handleError : undefined}
      />
    </div>
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
