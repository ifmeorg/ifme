// @flow
import React from 'react';
import css from './Input.scss';

type Props = {
  dark?: boolean,
  large?: boolean,
  id?: string,
  type?: string,
  name?: string,
  value?: string | number,
  placeholder?: string,
  label?: string,
  readonly?: boolean,
  disabled?: boolean,
  required?: boolean,
  minLength?: number,
  maxLength?: number,
};

type State = {
  value: string | number,
  active: boolean,
};

export class Input extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { value: this.props.value || '', active: false };
  }

  onChange = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    this.setState({ value: e.currentTarget.value });
  };

  onFocus = () => {
    this.setState({ active: true });
  };

  onBlur = () => {
    this.setState({ active: false });
  };

  render() {
    const {
      dark,
      large,
      label,
      id,
      type,
      name,
      placeholder,
      readonly,
      disabled,
      required,
      minLength,
      maxLength,
    } = this.props;

    const labelClassNames = `${css.label} ${dark ? css.dark : ''}
      ${large ? css.large : ''} ${this.state.active ? css.active : ''}`;

    const inputClassNames = `${css.input} ${dark ? css.dark : ''}
    ${large ? css.large : ''}`;

    return (
      <div>
        <div className={labelClassNames}>{label}</div>
        <input
          className={inputClassNames}
          id={id}
          type={type}
          name={name}
          value={this.state.value}
          placeholder={placeholder}
          readOnly={readonly}
          disabled={disabled}
          required={required}
          minLength={minLength}
          maxLength={maxLength}
          onChange={this.onChange}
          onFocus={this.onFocus}
          onBlur={this.onBlur}
        />
      </div>
    );
  }
}
