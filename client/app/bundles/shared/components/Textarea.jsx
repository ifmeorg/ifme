//@flow
import React from "react";
import css from "./Textarea.scss";

type Props = {
  id?: string,
  name?: string,
  form?: string,
  rows?: number,
  placeholder?: string,
  label?: string,
  value?: string,
  readonly?: boolean,
  disabled?: boolean,
  required?: boolean,
  maxLength?: number
};

type State = {
  value: string | number,
  active: boolean
};

export default class Input extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { value: this.props.value || "", active: false };
  }

  onChange = (e: SyntheticEvent<HTMLInputElement>) => {
    e.preventDefault();
    this.setState({ value: e.currentTarget.value });
  };

  onFocus = (e: SyntheticMouseEvent<HTMLInputElement>) => {
    this.setState({ active: true });
  };

  onBlur = (e: SyntheticMouseEvent<HTMLInputElement>) => {
    this.setState({ active: false });
  };

  render() {
    const {
      id,
      name,
      form,
      rows,
      cols,
      placeholder,
      label,
      value,
      readonly,
      disabled,
      required,
      maxLength
    } = this.props;

    const labelClassNames = `${css.label} ${dark ? css.dark : ""} 
      ${large ? css.large : ""} ${this.state.active ? css.active : ""}`;

    const inputClassNames = `${css.input} ${dark ? css.dark : ""} 
    ${large ? css.large : ""}`;

    return (
      <div>
        <div className={labelClassNames}>{label}</div>
        <textarea
          id={id}
          name={name}
          form={form}
          rows={rows}
          cols={cols}
          placeholder={placeholder}
          label={label}
          value={value}
          readonly={readonly}
          disabled={disabled}
          required={required}
          maxLength={maxLength}
          onChange={this.onChange}
          onFocus={this.onFocus}
          onBlur={this.onBlur}
        />
      </div>
    );
  }
}
