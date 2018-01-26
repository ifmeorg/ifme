//@flow
import React from "react";
import css from "./Input.scss";

type Props = {
  dark?: boolean,
  type?: string,
  name?: string,
  value?: string | number,
  placeholder?: string,
  label?: string,
  value?: string,
  readonly?: boolean,
  disabled?: boolean,
  required?: boolean,
  minLength?: number,
  maxLength?: number
};

type State = {
  value: string | number
}

export default class Input extends React.Component<Props, State> {
  constructor(props : Props) {
    super(props);
    this.state = { value: this.props.value || "" };
  }

  onChange = (e : SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    this.setState({ value: e.currentTarget.value });
  };

  render() {
    const {dark, label, name, placeholder, type, readonly, disabled, required, minLength, maxLength } = this.props;
    return (
        <div>
          <div className={dark ? css.labelDark : css.labelLight}>{label}</div>
          <input
            className={dark ? css.inputDark : css.inputLight}
            type={type}
            name={name}
            value={this.state.value}
            placeholder={placeholder}
            readonly={readonly}
            disabled={disabled}
            required={required}
            minLength={minLength}
            maxLength={maxLength}
            onChange={this.onChange}
          />
        </div>
    );
  }
}
