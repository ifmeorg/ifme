// @flow
import React from 'react';
import globalCss from '../../styles/_global.scss';

export type Props = {
  id: string,
  large?: boolean,
  dark?: boolean,
  value?: any,
  onClick?: Function,
};

export const InputSubmit = (props: Props) => {
  const {
    id, large, dark, onClick, value,
  } = props;
  let buttonClassName = globalCss.buttonGhostM;
  if (large && !dark) {
    buttonClassName = globalCss.buttonGhostL;
  } else if (large && dark) {
    buttonClassName = globalCss.buttonDarkL;
  } else if (dark) {
    buttonClassName = globalCss.buttonDarkM;
  }
  return (
    <input
      id={id}
      type="submit"
      name="commit"
      value={value}
      className={buttonClassName}
      onClick={onClick}
    />
  );
};
