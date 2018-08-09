// @flow
import React, { type StatelessFunctionalComponent } from 'react';
import css from './Logo.scss';

export interface Props {
  link?: string;
  sm?: boolean;
  lg?: boolean;
}

const ifDisplay = <div className={css.if}>if</div>;
const meDisplay = <div className={css.me}>me</div>;

const sizeClass = (sm, lg) => {
  if (sm) return css.sm;
  if (lg) return css.lg;
  return '';
};

export function LogoFactory(
  size: string = '',
): StatelessFunctionalComponent<Props> {
  const LogoComponent = ({ link, sm, lg }: Props) => {
    const containerClass = `${css.logo} ${css[size] || ''} ${sizeClass(
      sm,
      lg,
    )}`;
    if (link) {
      return (
        <a href={link} className={containerClass}>
          {ifDisplay}
          {meDisplay}
        </a>
      );
    }
    return (
      <div role="presentation" className={containerClass}>
        {ifDisplay}
        {meDisplay}
      </div>
    );
  };
  return LogoComponent;
}
