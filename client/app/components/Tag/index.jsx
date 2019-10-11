// @flow
import React from 'react';
import css from './Tag.scss';

type Props = {
  dark?: boolean,
  normal?: boolean,
  label?: string,
  secondary?: boolean,
  onClick?: Function
};

export const Tag = (props: Props) => {
  const {
    dark, normal, label, secondary, onClick
  } = props;
  const labelClassNames = `tag ${css.tag} ${dark ? css.dark : ''} ${
    normal ? css.normal : ''
  } ${secondary ? css.secondary : ''}`;
  return <div onClick={() => onClick(label)} className={labelClassNames}>{label}</div>;
};
