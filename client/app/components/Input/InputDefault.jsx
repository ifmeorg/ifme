// @flow
import React from 'react';
import css from './Input.scss';

export const REQUIRES_DEFAULT = ['text', 'number', 'time', 'date'];

export type Props = {
  id: string,
  type: string,
  name?: string,
  value?: any,
  placeholder?: string,
  readOnly?: boolean,
  disabled?: boolean,
  required?: boolean,
  minLength?: number,
  maxLength?: number,
  min?: number,
  max?: number,
  hasError?: Function,
};

export type State = {
  value: any,
};

export class InputDefault extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { value: props.value || '' };
  }

  changeValue = (e: SyntheticEvent<HTMLInputElement>) => {
    const { required, hasError } = this.props;
    const { value } = e.currentTarget;
    if (required && hasError) {
      hasError(!value);
    }
    this.setState({ value });
  };

  onBlur = () => {
    const { required, hasError } = this.props;
    const { value } = this.state;
    if (required && hasError) {
      hasError(!value);
    }
  };

  render() {
    const {
      id,
      type,
      name,
      placeholder,
      readOnly,
      disabled,
      required,
      minLength,
      maxLength,
      min,
      max,
    } = this.props;
    const { value } = this.state;
    if (!REQUIRES_DEFAULT.includes(type)) return null;
    return (
      <input
        className={css.default}
        id={id}
        type={type}
        name={name}
        value={value}
        placeholder={placeholder}
        readOnly={readOnly}
        disabled={disabled}
        required={required}
        minLength={minLength}
        maxLength={maxLength}
        min={min}
        max={max}
        onChange={this.changeValue}
        onBlur={this.onBlur}
      />
    );
  }
}
