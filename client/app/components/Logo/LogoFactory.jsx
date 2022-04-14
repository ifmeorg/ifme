// @flow
import React from 'react';
import { I18n } from 'libs/i18n';
import css from './Logo.scss';

export type Props = {
  link?: string,
  sm?: boolean,
  lg?: boolean,
};

const ifDisplay = <div className={css.if}>if</div>;
const meDisplay = <div className={css.me}>me</div>;

const sizeClass = (sm, lg) => {
  if (sm) return css.sm;
  if (lg) return css.lg;
  return '';
};

export const LogoFactory = (size: string = ''): any => {
  const LogoComponent = ({ link, sm, lg }: Props): any => {
    const containerClass = `${css.logo} ${css[size] || ''} ${sizeClass(
      sm,
      lg,
    )}`;
    if (link) {
      return (
        <a
          href={link}
          className={containerClass}
          aria-label={I18n.t('shared.header.home')}
        >
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
};
