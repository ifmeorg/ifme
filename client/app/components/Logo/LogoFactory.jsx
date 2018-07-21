// @flow
import React, { type StatelessFunctionalComponent } from 'react';
import css from './Logo.scss';

type Props = {
  onClick?: (event: SyntheticEvent<>) => void,
};

export function LogoFactory(
  size: string = '',
): StatelessFunctionalComponent<Props> {
  const LogoComponent = ({ onClick }: Props) => {
    const linkClass = onClick ? 'link' : '';
    const containerClass = `${css.logo} ${css[size] || ''} ${linkClass}`;

    return (
      <div role="presentation" className={containerClass} onClick={onClick}>
        <div className={css.content}>
          <div>
            <span className={css.if}>if</span>
            <span className={css.me}>me</span>
          </div>
        </div>
      </div>
    );
  };

  LogoComponent.defaultProps = {
    onClick: undefined,
  };

  return LogoComponent;
}
