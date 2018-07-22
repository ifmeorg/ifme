// @flow
import React from 'react';
import css from './Textarea.scss';

type Props = {
  id?: string,
  name?: string,
  value?: string,
  form?: string,
  rows?: string | number,
  cols?: string | number,
  placeholder?: string,
  label?: string,
  readonly?: boolean,
  disabled?: boolean,
  required?: boolean,
  maxLength?: number,
};

type State = {
  value: string,
  active: boolean,
};

export class Textarea extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      value: props.value || '',
      active: false,
    };
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

  labelClassNames = () => `${css.label} ${this.state.active ? css.active : ''}`;

  render() {
    const {
      id,
      form,
      name,
      rows,
      cols,
      placeholder,
      label,
      readonly,
      disabled,
      required,
      maxLength,
    } = this.props;

    return (
      <div>
        <div className={this.labelClassNames()}>{label}</div>
        <textarea
          className={css.textarea}
          id={id}
          name={name}
          value={this.state.value}
          form={form}
          rows={rows}
          cols={cols}
          placeholder={placeholder}
          label={label}
          readOnly={readonly}
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
