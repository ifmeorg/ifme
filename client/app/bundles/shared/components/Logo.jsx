// @flow
import React from 'react';
import css from './Logo.scss';

type Props = {
  onClick?: () => any;
  size?: string; // Future Task: Use ScreenSize enum
}

// eslint-disable-next-line react/prefer-stateless-function
export default class Logo extends React.Component<Props, {}> {
  render() {
    const { onClick, size = '' } = this.props;
    const linkClass = onClick ? 'link' : '';
    const containerClass = `${css.container} ${css[size] || ''} ${linkClass}`;

    return (
      <div role={'presentation'} className={containerClass} onClick={onClick}>
        <span className={css.if}>if</span>
        <span className={css.me}>me</span>
      </div>
    );
  }
}
