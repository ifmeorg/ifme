// @flow
import React from 'react';
import { InputTextarea } from './InputTextarea';
import { InputLabel } from './InputLabel';
import { InputSubmit } from './InputSubmit';
import { InputCheckbox } from './InputCheckbox';
import { InputCheckboxGroup } from './InputCheckboxGroup';
import { InputSelect } from './InputSelect';
import { InputTag } from './InputTag';
import { InputSwitch } from './InputSwitch';
import {
  InputDefault,
  REQUIRES_DEFAULT,
  DEFAULT_WITH_LABEL,
} from './InputDefault';
import { Accordion } from '../Accordion';
import css from './Input.scss';

export const TYPES = REQUIRES_DEFAULT.concat([
  'textarea',
  'submit',
  'checkbox',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
]);

const REQUIRES_LABEL = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'select',
  'checkboxGroup',
  'tag',
  'switch',
]);

const REQUIRED_POSSIBLE = DEFAULT_WITH_LABEL.concat([
  'textarea',
  'checkboxGroup',
]);

export type Option = {
  id: string,
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
    | 'checkboxGroup'
    | 'tag'
    | 'hidden'
    | 'switch',
  name?: string,
  label?: string,
  placeholder?: string,
  error?: boolean,
  dark?: boolean,
  small?: boolean,
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
  myRef?: any,
  accordionOpen?: boolean,
  formNoValidate?: boolean,
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
      myRef,
      label,
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
        myRef={myRef}
        label={label}
      />
    );
  };

  displaySubmit = () => {
    const {
      id,
      onClick,
      value,
      large,
      small,
      dark,
      type,
      disabled,
      formNoValidate,
    } = this.props;
    if (type === 'submit' && value) {
      return (
        <InputSubmit
          id={id}
          onClick={onClick}
          value={value}
          large={large}
          small={small}
          dark={dark}
          disabled={disabled}
          formNoValidate={formNoValidate}
        />
      );
    }
    return null;
  };

  displayTextarea = () => {
    const {
      value, id, name, required, type, myRef, dark,
    } = this.props;
    if (type !== 'textarea') return null;
    return (
      <InputTextarea
        value={value}
        id={id}
        name={name}
        required={required}
        hasError={(error: boolean) => this.hasError(error)}
        myRef={myRef}
        dark={dark}
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
    if (type === 'checkbox' && typeof value !== 'undefined' && label) {
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

  displayTag = () => {
    const {
      type, checkboxes, name, id, placeholder, onChange,
    } = this.props;
    if (type === 'tag' && checkboxes && name) {
      return (
        <InputTag
          id={id}
          name={name}
          checkboxes={checkboxes}
          placeholder={placeholder}
          onChange={onChange}
        />
      );
    }
    return null;
  };

  displaySwitch = () => {
    const {
      type,
      id,
      name,
      label,
      value,
      checked,
      uncheckedValue,
    } = this.props;
    if (type === 'switch' && label && name) {
      return (
        <InputSwitch
          id={id}
          name={name}
          label={label}
          value={value}
          checked={checked}
          uncheckedValue={uncheckedValue}
        />
      );
    }
    return null;
  };

  displayLabel = () => {
    const {
      label, info, required, type,
    } = this.props;
    const { error } = this.state;
    if (REQUIRES_LABEL.includes(type) && label) {
      return (
        <InputLabel
          label={label}
          required={REQUIRED_POSSIBLE.includes(type) && required}
          info={info}
          error={error}
        />
      );
    }
    return null;
  };

  render() {
    const {
      type,
      dark,
      small,
      large,
      accordion,
      label,
      accordionOpen,
      id,
    } = this.props;
    if (!TYPES.includes(type)) return null;
    const content = (
      <div
        className={`${dark ? css.dark : ''} ${large ? css.large : ''} ${
          small ? css.small : ''
        } ${type === 'hidden' ? css.hidden : ''}`}
      >
        {!accordion && (
          <div className={css.labelNoAccordion}>{this.displayLabel()}</div>
        )}
        {this.displayDefault()}
        {this.displayCheckbox()}
        {this.displayCheckboxGroup()}
        {this.displaySelect()}
        {this.displayTextarea()}
        {this.displayTag()}
        {this.displaySwitch()}
        {this.displaySubmit()}
      </div>
    );
    return accordion && label ? (
      <Accordion
        id={id}
        title={this.displayLabel()}
        open={accordionOpen}
        dark={dark}
        large={large}
      >
        {content}
      </Accordion>
    ) : (
      content
    );
  }
}
