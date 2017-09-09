// @flow
import React from 'react';

import HeaderProps from '../models/HeaderProps';
import Logo from './Logo';

import css from './Header.scss';

export default class HeaderSignedIn extends React.Component<HeaderProps, {}> {
  render() {
    return (
      <div className={css.container}>
        <Logo size={this.props.size} />
      </div>
    );
  }
}
