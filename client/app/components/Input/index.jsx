// @flow
import React from 'react';
import { InputTextarea } from './InputTextarea';
import { InputLabel } from './InputLabel';
import { InputSubmit } from './InputSubmit';
import { InputCheckbox } from './InputCheckbox';
import { InputCheckboxGroup } from './InputCheckboxGroup';
import { InputSelect } from './InputSelect';
import { InputDefault } from './InputDefault';
import css from './Input.scss';

const REQUIRES_LABEL = [
  'textarea',
  'text',
  'number',
  'time',
  'date',
  'select',
  'checkboxGroup',
];

const REQUIRES_DEFAULT = ['text', 'number', 'time', 'date'];

export type Option = {
  value: any,
  label: string,
};

export type Checkbox = {
  id: string,
  name?: string,
  value?: any,
  checked?: boolean,
  uncheckedValue?: any,
  label?: string,
  onClick?: Function,
  info?: string,
};

export type Props = {
  id: string,
  type: | 'text'
    | 'textarea'
    | 'submit'
    | 'checkbox'
    | 'number'
    | 'time'
    | 'date'
    | 'select'
    | 'checkboxGroup',
  name?: string,
  label?: string,
  placeholder?: string,
  error?: boolean,
  dark?: boolean,
  large?: boolean,
  value?: any,
  readOnly?: boolean,
  disabled?: boolean,
  required?: boolean,
  info?: string,
  minLength?: number,
  maxLength?: number,
  onClick?: Function,
  onChange?: Function,
  checked?: boolean,
  uncheckedValue?: any,
  min?: number,
  max?: number,
  options?: Option[],
  checkboxes?: Checkbox[],
  onError?: Function,
};

export type State = {
  error: boolean,
};

export class Input extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { error: !!props.error };
  }

  displayDefault = () => {
    const {
      id,
      type,
      name,
      value,
      placeholder,
      readOnly,
      disabled,
      required,
      minLength,
      maxLength,
      min,
      max,
    } = this.props;
    return (
      <InputDefault
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
        hasError={(error: boolean) => this.hasError(error)}
      />
    );
  };

  displaySubmit = () => {
    const {
      id, onClick, value, large, dark,
    } = this.props;
    return (
      <InputSubmit
        id={id}
        onClick={onClick}
        value={value}
        large={large}
        dark={dark}
      />
    );
  };

  displayTextarea = () => {
    const {
      value, id, name, required,
    } = this.props;
    return (
      <InputTextarea
        value={value}
        id={id}
        name={name}
        required={required}
        hasError={(error: boolean) => this.hasError(error)}
      />
    );
  };

  displayCheckbox = () => {
    const {
      id,
      name,
      value,
      checked,
      uncheckedValue,
      label,
      info,
      onClick,
    } = this.props;
    return (
      <InputCheckbox
        id={id}
        name={name}
        value={value}
        checked={checked}
        uncheckedValue={uncheckedValue}
        label={label}
        info={info}
        onClick={onClick}
      />
    );
  };

  hasError = (error: boolean) => {
    const { onError, id } = this.props;
    if (onError) {
      onError(id, error);
    }
    this.setState({ error });
  };

  displayCheckboxGroup = () => {
    const { checkboxes, required } = this.props;
    if (!checkboxes) return null;
    return (
      <InputCheckboxGroup
        checkboxes={checkboxes}
        required={required}
        hasError={(error: boolean) => this.hasError(error)}
      />
    );
  };

  displaySelect = () => {
    const {
      options, name, id, value, onChange,
    } = this.props;
    if (!options) return null;
    return (
      <InputSelect
        name={name}
        id={id}
        value={value}
        options={options}
        onChange={onChange}
      />
    );
  };

  displayLabel = () => {
    const {
      label, info, required, id,
    } = this.props;
    const { error } = this.state;
    if (label || info || required || error) {
      return (
        <InputLabel
          label={label}
          required={required}
          info={info}
          id={id}
          error={error}
        />
      );
    }
    return null;
  };

  render() {
    const { type, dark, large } = this.props;
    return (
      <div className={`${dark ? css.dark : ''} ${large ? css.large : ''}`}>
        {REQUIRES_LABEL.includes(type) && this.displayLabel()}
        {REQUIRES_DEFAULT.includes(type) && this.displayDefault()}
        {type === 'checkbox' && this.displayCheckbox()}
        {type === 'checkboxGroup' && this.displayCheckboxGroup()}
        {type === 'select' && this.displaySelect()}
        {type === 'submit' && this.displaySubmit()}
        {type === 'textarea' && this.displayTextarea()}
      </div>
    );
  }
}
