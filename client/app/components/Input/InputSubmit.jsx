// @flow
import React from 'react';
import globalCss from '../../styles/_global.scss';

export type Props = {
  id: string,
  name: string,
  small?: boolean,
  large?: boolean,
  dark?: boolean,
  value: any,
  disabled?: boolean,
  onClick?: Function,
  formNoValidate?: boolean,
};

const buttonClassName = (small: ?boolean, large: ?boolean, dark: ?boolean) => {
  const theme = dark ? 'Dark' : 'Ghost';
  const smallOrRegular = small ? 'S' : 'M';
  const size = large ? 'L' : smallOrRegular;
  return globalCss[`button${theme}${size}`];
};

export const InputSubmit = ({
  id,
  name,
  small,
  large,
  dark,
  onClick,
  value,
  disabled,
  formNoValidate,
}: Props) => (
  <input
    id={id}
    type="submit"
    name={name}
    value={value}
    disabled={disabled}
    className={buttonClassName(small, large, dark)}
    onClick={onClick}
    formNoValidate={formNoValidate}
  />
);
