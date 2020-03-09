// @flow
import React from 'react';
import css from './Input.scss';
import type { Password as Props } from './utils';

const ShowPassword = (show, text, onChange, onClick) => (
  <div>
    <input
      type = {show ? "text" : "password"}
      value = {text}
      onChange = {(event: SyntheticEvent<HTMLInputElement>) => handleOnChange(event, onChange, text)}
    />
    <button onClick = {(event: SyntheticEvent<HTMLButtonElement>) => toggleShow(event, onClick, show)}>Show/Hide</button>
  </div>
);

const handleOnChange = (
  event: SyntheticEvent<HTMLInputElement>,
  onChange?: Function,
  text: string,
) => {
  text = event.currentTarget.value;
  if (onChange) {
    onChange({ text });
  }
};

const toggleShow = (
  event: SyntheticEvent<HTMLButtonElement>,
  onClick?: Function,
  show: boolean,
) => {
  (event.currentTarget: HTMLButtonElement);
  show = !(show);
  // if (onClick) {
  //   onClick({ show });
//   }
};

export const InputPassword = (props: Props) => {
  const {
    show,
    text,
    onChange,
    onClick,
  } = props;
  return (
    <div>
    { ShowPassword(show, text, onChange, onClick) }
    </div>
  );
}
