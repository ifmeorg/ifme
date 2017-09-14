// @flow
import React from 'react';
import css from './Logo.scss';

type Props = {
  onClick?: () => any;
  size?: string; // Future Task: Use ScreenSize enum
}

export default class Logo extends React.Component<Props, {}> {
  render() {
    const { onClick, size = '' } = this.props;
    const linkClass = onClick ? 'link' : '';
    const containerClass = `${css.container} ${css[size] || ''} ${linkClass}`;

    return (
      <div className={containerClass} onClick={onClick}>
        <span className={css.if}>if</span>
        <span className={css.me}>me</span>
      </div>
    );
  }
}
