// @flow
import React from 'react';
import css from './Bullet.scss';

type Props = {
  normal?: boolean,
  active?: boolean,
  label: string
};

export const Bullet = (props: Props) => {
  const {
    normal, label, active
  } = props;
  const labelClassNames = `bullet ${css.bullet} ${active ? css.active : ''} 
  ${normal ? css.normal : ''}`;
  return <div className={labelClassNames}><span>{label}</span></div>;
};
