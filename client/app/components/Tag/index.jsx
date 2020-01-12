// @flow
import React from 'react';
import css from './Tag.scss';

type Props = {
  dark?: boolean,
  normal?: boolean,
  label?: string,
  secondary?: boolean,
  onClick?: Function,
};

const labelClassNames = ({
  dark, normal, secondary, onClick,
}) => `tag ${css.tag} ${dark ? css.dark : ''} ${normal ? css.normal : ''} ${
  secondary ? css.secondary : ''
} ${onClick ? css.clickable : ''}`;

export const Tag = (props: Props) => {
  const {
    dark, normal, label, secondary, onClick,
  } = props;
  return (
    <div
      onClick={onClick ? () => onClick(label) : null}
      role="button"
      tabIndex={0}
      onKeyDown={onClick ? () => onClick(label) : null}
      className={labelClassNames({
        dark, normal, secondary, onClick,
      })}
    >
      {label}
    </div>
  );
};
