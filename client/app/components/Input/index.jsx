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

  labelClassNames = () => {
    const { dark, large } = this.props;
    return `${css.label} ${dark ? css.dark : ''} ${large ? css.large : ''} ${
      this.state.active ? css.active : ''
    }`;
  };

  inputClassNames = () => {
    const { dark, large } = this.props;
    return `${css.input} ${dark ? css.dark : ''} ${large ? css.large : ''}`;
  };

  render() {
    return (
      <div>
        <div className={this.labelClassNames()}>{this.props.label}</div>
        <input
          className={this.inputClassNames()}
          id={this.props.id}
          type={this.props.type}
          name={this.props.name}
          value={this.state.value}
          placeholder={this.props.placeholder}
          readOnly={this.props.readonly}
          disabled={this.props.disabled}
          required={this.props.required}
          minLength={this.props.minLength}
          maxLength={this.props.maxLength}
          onChange={this.onChange}
          onFocus={this.onFocus}
          onBlur={this.onBlur}
        />
      </div>
    );
  }
}
