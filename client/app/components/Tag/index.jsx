// @flow
import React from 'react';
import css from './Tag.scss';

type Props = {
  dark?: boolean,
  normal?: boolean,
  label?: string,
  secondary?: boolean,
  onClick?: Function,
  href?: string,
};

const labelClassNames = ({
  dark, normal, secondary, onClick,
} = {}) => `tag ${css.tag} ${dark ? css.dark : ''} ${normal ? css.normal : ''} ${
  secondary ? css.secondary : ''
} ${onClick ? css.clickable : ''}`;

export const Tag = ({
  dark,
  normal,
  label,
  secondary,
  onClick,
  href,
}: Props) => {
  if (href) {
    return (
      <a
        className={labelClassNames({
          dark,
          normal,
          secondary,
          onClick,
        })}
        href={href}
      >
        {label}
      </a>
    );
  }
  if (onClick) {
    return (
      <button
        type="button"
        onClick={() => onClick(label)}
        onKeyDown={() => onClick(label)}
        className={labelClassNames({
          dark,
          normal,
          secondary,
          onClick,
        })}
      >
        {label}
      </button>
    );
  }
  return (
    <div
      className={labelClassNames({
        dark,
        normal,
        secondary,
        onClick,
      })}
    >
      {label}
    </div>
  );
};
