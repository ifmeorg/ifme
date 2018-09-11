// @flow
import React from 'react';
import css from './Tag.scss';

type Props = {
  dark?: boolean,
  normal?: boolean,
  label?: string,
};

export const Tag = (props: Props) => {
  const { dark, normal, label } = props;
  const labelClassNames = `tag ${css.tag} ${dark ? css.dark : ''}${
    normal ? css.normal : ''
  }`;
  return <span className={labelClassNames}>{label}</span>;
};
