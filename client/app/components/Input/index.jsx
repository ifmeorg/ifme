// @flow
import React from 'react';
import { InputTextarea } from './InputTextarea';
import { InputLabel } from './InputLabel';
import { InputSubmit } from './InputSubmit';
import { InputCheckbox } from './InputCheckbox';
import { InputCheckboxGroup } from './InputCheckboxGroup';
import { InputSelect } from './InputSelect';
import { InputDefault, REQUIRES_DEFAULT } from './InputDefault';
import { Accordion } from '../Accordion';
import css from './Input.scss';

const TYPES = [
  'text',
  'textarea',
  'submit',
  'checkbox',
  'number',
  'time',
  'date',
  'select',
  'checkboxGroup',
];

const REQUIRES_LABEL = [
  'textarea',
  'text',
  'number',
  'time',
  'date',
  'select',
  'checkboxGroup',
];

export type Option = {
  value: any,
  label: string,
};

export type Checkbox = {
  id: string,
  name?: string,
  value: any,
  checked?: boolean,
  uncheckedValue?: any,
  label: string,
  onChange?: Function,
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
  accordion?: boolean,
  key?: string,
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
    if (!REQUIRES_DEFAULT.includes(type)) return null;
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
      id, onClick, value, large, dark, type, disabled,
    } = this.props;
    if (type === 'submit' && value) {
      return (
        <InputSubmit
          id={id}
          onClick={onClick}
          value={value}
          large={large}
          dark={dark}
          disabled={disabled}
        />
      );
    }
    return null;
  };

  displayTextarea = () => {
    const {
      value, id, name, required, type,
    } = this.props;
    if (type !== 'textarea') return null;
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
      onChange,
      type,
    } = this.props;
    if (type === 'checkbox' && value && label) {
      return (
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          checked={checked}
          uncheckedValue={uncheckedValue}
          label={label}
          info={info}
          onChange={onChange}
        />
      );
    }
    return null;
  };

  hasError = (error: boolean) => {
    const { onError, id } = this.props;
    if (onError) {
      onError(id, error);
    }
    this.setState({ error });
  };

  displayCheckboxGroup = () => {
    const { checkboxes, required, type } = this.props;
    if (type === 'checkboxGroup' && checkboxes) {
      return (
        <InputCheckboxGroup
          checkboxes={checkboxes}
          required={required}
          hasError={(error: boolean) => this.hasError(error)}
        />
      );
    }
    return null;
  };

  displaySelect = () => {
    const {
      options, name, id, value, onChange, type,
    } = this.props;
    if (type === 'select' && options) {
      return (
        <InputSelect
          name={name}
          id={id}
          value={value}
          options={options}
          onChange={onChange}
        />
      );
    }
    return null;
  };

  displayLabel = () => {
    const {
      label, info, required, id, type,
    } = this.props;
    const { error } = this.state;
    if (REQUIRES_LABEL.includes(type) && label) {
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
    const {
      type, dark, large, accordion, label, key,
    } = this.props;
    if (!TYPES.includes(type)) return null;
    const content = (
      <div
        key={key}
        className={`${dark ? css.dark : ''} ${large ? css.large : ''}`}
      >
        {!accordion && (
          <div className={css.labelNoAccordion}>{this.displayLabel()}</div>
        )}
        {this.displayDefault()}
        {this.displayCheckbox()}
        {this.displayCheckboxGroup()}
        {this.displaySelect()}
        {this.displaySubmit()}
        {this.displayTextarea()}
      </div>
    );
    return accordion && label ? (
      <Accordion title={this.displayLabel()} dark={dark} large={large}>
        {content}
      </Accordion>
    ) : (
      content
    );
  }
}
