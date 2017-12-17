// @flow
import React from 'react';

import HeaderProps from '../models/HeaderProps';
import HeaderSignedIn from './HeaderSignedIn';
import HeaderSignedOut from './HeaderSignedOut';

export default class Header extends React.Component<HeaderProps, {}> {
  render() {
    const { size, userSignedIn } = this.props;
    const headerElement = userSignedIn
      ? <HeaderSignedIn size={size} />
      : <HeaderSignedOut size={size} />;

    return (
      <header id="header">
        <div id="header_content">
          {headerElement}
        </div>
      </header>
    );
  }
}
