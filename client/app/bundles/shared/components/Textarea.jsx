//@flow
import React from "react";
import css from "./Textarea.scss";

type Props = {
  id?: string,
  name?: string,
  form?: string,
  rows?: string,
  cols?: string,
  placeholder?: string,
  label?: string,
  autofocus?: boolean,
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
    this.state = { value: "", active: false };
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
      form,
      name,
      value,
      rows,
      cols,
      placeholder,
      label,
      autofocus,
      readonly,
      disabled,
      required,
      maxLength
    } = this.props;

    const labelClassNames = `${css.label} ${
      this.state.active ? css.active : ""
    }`;

    return (
      <div>
        <div className={labelClassNames}>{label}</div>
        <textarea
          className={css.textarea}
          id={id}
          name={name}
          value={value}
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
