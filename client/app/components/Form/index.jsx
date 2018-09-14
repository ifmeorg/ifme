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
  myRefs: Object;

  constructor(props: Props) {
    super(props);
    const inputs = props.inputs.filter((input: FormInput) => input !== {});
    this.state = { inputs, errors: {} };
    this.myRefs = {};
  }

  handleError = (id: string, error: boolean) => {
    const { errors } = this.state;
    const newErrors = Object.assign({}, errors);
    newErrors[id] = error;
    this.setState({ errors: newErrors });
  };

  isInputError = (input: InputProps) => (REQUIRES_DEFAULT.includes(input.type) || input.type === 'textarea')
    && input.required
    && this.myRefs[input.id]
    && !this.myRefs[input.id].value;

  clickSubmit = (e: SyntheticEvent<HTMLInputElement>) => {
    // Get errors from inputs that were never focused
    const { inputs, errors } = this.state;
    const newErrors = Object.assign({}, errors);
    const newInputs = inputs.map((input: InputProps) => {
      const newInput = Object.assign({}, input);
      if (this.isInputError(newInput)) {
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
        myRef={(element) => {
          this.myRefs[input.id] = element;
        }}
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
