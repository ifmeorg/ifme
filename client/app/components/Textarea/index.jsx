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
    return (
      <div>
        <div className={this.labelClassNames()}>{this.props.label}</div>
        <textarea
          className={css.textarea}
          id={this.props.id}
          name={this.props.name}
          value={this.state.value}
          form={this.props.form}
          rows={this.props.rows}
          cols={this.props.cols}
          placeholder={this.props.placeholder}
          label={this.props.label}
          readOnly={this.props.readonly}
          disabled={this.props.disabled}
          required={this.props.required}
          maxLength={this.props.maxLength}
          onChange={this.onChange}
          onFocus={this.onFocus}
          onBlur={this.onBlur}
        />
      </div>
    );
  }
}
