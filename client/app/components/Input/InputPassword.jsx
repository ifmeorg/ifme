// @flow
import React from 'react';
import css from './Input.scss';
import type { Password as Props } from './utils';

const ShowPassword = (show, text) => (
  <div>
    <input
      type = {show) ? "text" : "password"
      value = {text}
      onChange = {(event: SyntheticEvent<HTMLInputElement>) => handleOnChange(event, onChange, text)}
    />
    <button onClick = {(event: SyntheticEvent<HTMLInputElement>) => toggleShow(event, onChange, show)}>Show/Hide</button>
  </div>
);

const handleOnChange = (
  event: SyntheticEvent<HTMLInputElement>,
  onChange?: Function,
  text: string,
) => {
  const { text } = event.currentTarget;
  if (onChange) {
    onChange({ text });
  }
};

const toggleShow = (
  event: SyntheticEvent<HTMLInputElement>,
  onChange?: Function,
  show: boolean,
) => {
  const { show } = !{ show };
  if (onChange) {
    onChange({ show });
  }
};

export const InputPassword = (props: Props) => {
  const {
    show,
    text,
    onChange,
  } = props;
  return (
    {ShowPassword(show, text, onChange)}
  );
}
