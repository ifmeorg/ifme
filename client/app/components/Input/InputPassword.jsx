// @flow
import React, { useState } from 'react';
import css from './InputPassword.scss';

export type Props = {
  text?: string,
  show?: boolean,
  onChange?: Function,
};

export type State = {
  show: boolean,
};

export function InputPassword({
  text,
  onChange,
  show: propShow,
}: Props) {
  const [show, setShow] = useState<boolean>(propShow || false);

  const handleOnChange = (e: SyntheticEvent<HTMLInputElement>) => {
    if (onChange) {
      onChange(e.currentTarget.value);
    }
  };

  const toggleShow = () => {
    setShow(!show);
  };

  return (
    <>
      <input
        type={show ? 'text' : 'password'}
        value={text}
        onChange={handleOnChange}
      />
      <button type="button" className={`${css.show}`} onClick={toggleShow} aria-label={show ? 'Hide password' : 'Show password'}>
        <i className={show ? 'fa fa-eye' : 'fa fa-eye-slash'} />
      </button>
    </>
  );
}
