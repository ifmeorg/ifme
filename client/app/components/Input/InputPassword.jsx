// @flow
import React, { useState } from 'react';
import { I18n } from '../../libs/i18n';
import css from './InputPassword.scss';

export type Props = {
  id: string,
  name?: string,
  value?: string,
  placeholder?: string,
  required?: boolean,
};

export type State = {
  showText: boolean,
};

export function InputPassword({
  id,
  name,
  value,
  placeholder,
  required,
}: Props) {
  const [showText, setShowText] = useState<boolean>(false);

  const toggleShow = () => {
    setShowText(!showText);
  };

  return (
    <div className={css.password}>
      <input
        type={showText ? 'text' : 'password'}
        id={id}
        name={name}
        placeholder={placeholder}
        required={required}
        defaultValue={value}
        autoComplete="off"
      />
      <button
        type="button"
        onClick={toggleShow}
        aria-label={showText ? I18n.t('devise.show_password') : I18n.t('devise.hide_password')}
      >
        <i className={showText ? 'fa fa-eye' : 'fa fa-eye-slash'} />
      </button>
    </div>
  );
}
