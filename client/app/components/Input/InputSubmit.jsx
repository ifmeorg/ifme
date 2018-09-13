// @flow
import React from 'react';
import globalCss from '../../styles/_global.scss';

export type Props = {
  id: string,
  large?: boolean,
  dark?: boolean,
  value: any,
  onClick?: Function,
};

const buttonClassName = (large: ?boolean, dark: ?boolean) => {
  if (large && !dark) {
    return globalCss.buttonGhostL;
  }
  if (large && dark) {
    return globalCss.buttonDarkL;
  }
  if (dark) {
    return globalCss.buttonDarkM;
  }
  return globalCss.buttonGhostM;
};

export const InputSubmit = (props: Props) => {
  const {
    id, large, dark, onClick, value,
  } = props;
  return (
    <input
      id={id}
      type="submit"
      name="commit"
      value={value}
      className={buttonClassName(large, dark)}
      onClick={onClick}
    />
  );
};
