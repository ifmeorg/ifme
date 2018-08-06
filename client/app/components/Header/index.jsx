// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBars, faTimes } from '@fortawesome/free-solid-svg-icons';
import ReactHtmlParser from 'react-html-parser';

import css from './Header.scss';

export interface Link {
  name: string;
  url: string;
  active?: boolean;
  dataMethod?: string;
  hideInMobile?: boolean;
}

export interface Props {
  home: Link;
  links: Link[];
  mobileOnly?: any;
}

export interface State {
  mobileNavOpen: boolean;
  toggled: boolean;
}

export class Header extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { mobileNavOpen: false, toggled: false };
  }

  toggle = () => {
    const { mobileNavOpen } = this.state;
    this.setState({ mobileNavOpen: !mobileNavOpen, toggled: true });
  };

  displayToggle = () => {
    const { mobileNavOpen, toggled } = this.state;
    if (toggled && mobileNavOpen) {
      return <FontAwesomeIcon icon={faTimes} />;
    }
    return <FontAwesomeIcon icon={faBars} />;
  };

  displayLinks = () => {
    const { links } = this.props;
    return links.map((link: Link) => (
      <div className={css.headerLink}>
        <a
          href={link.url}
          className={`${link.active ? css.headerActiveLink : ''} ${
            link.hideInMobile ? css.headerHideInMobile : ''
          }`}
          data-method={`${link.dataMethod || ''}`}
          rel={`${link.dataMethod ? 'nofollow' : ''}`}
        >
          {link.name}
        </a>
      </div>
    ));
  };

  displayDesktop = () => {
    const { home } = this.props;
    return (
      <div className={css.headerDesktop}>
        <div className={css.headerDesktopHome}>
          <a href={home.url}>{home.name}</a>
        </div>
        <div className={css.headerDesktopNav}>
          <div
            id="headerHamburger"
            className={css.headerHamburger}
            onClick={() => this.toggle()}
            role="button"
            tabIndex="0"
          >
            {this.displayToggle()}
          </div>
          <div className={css.headerDesktopNavLinks}>{this.displayLinks()}</div>
        </div>
      </div>
    );
  };

  displayMobile = () => {
    const { mobileOnly } = this.props;
    return (
      <div id="headerMobile" className={css.headerMobileNav}>
        <div>
          {mobileOnly ? ReactHtmlParser(mobileOnly) : null}
          {this.displayLinks()}
        </div>
      </div>
    );
  };

  render() {
    const { mobileNavOpen } = this.state;
    return (
      <div
        id="header"
        className={`${css.header} ${mobileNavOpen ? css.headerMobile : ''}`}
      >
        <div className={`${mobileNavOpen ? css.headerMobileBg : ''}`}>
          {this.displayDesktop()}
          {mobileNavOpen ? this.displayMobile() : null}
        </div>
      </div>
    );
  }
}
