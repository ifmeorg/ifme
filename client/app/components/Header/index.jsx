// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBars, faTimes } from '@fortawesome/free-solid-svg-icons';
import ReactHtmlParser from 'react-html-parser';
import { Logo } from '../Logo';
import { HeaderProfile } from './HeaderProfile';
import css from './Header.scss';
import { I18n } from '../../libs/i18n';

export type Link = {
  name: string,
  url: string,
  active?: boolean,
  dataMethod?: string,
  hideInMobile?: boolean,
};

export type Profile = {
  avatar?: string,
  name: string,
  profile: Link,
  account: Link,
  notifications: {
    plural: string,
    none: string,
    clear: string,
  },
};

export type Props = {
  home: Link,
  links: Link[],
  mobileOnly?: any,
  profile?: Profile,
};

export type State = {
  mobileNavOpen: boolean,
  toggled: boolean,
};

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
    const body = ((document.body: any): HTMLBodyElement);
    if (toggled && mobileNavOpen) {
      body.classList.add('bodyHeaderOpen');
      return <FontAwesomeIcon icon={faTimes} />;
    }
    body.classList.remove('bodyHeaderOpen');
    return <FontAwesomeIcon icon={faBars} />;
  };

  displayLinks = (): any => {
    const { links } = this.props;
    return links.map((link: Link) => (
      <div className={css.headerLink} key={link.name}>
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
    const { mobileNavOpen } = this.state;
    return (
      <div className={css.headerDesktop}>
        <div className={css.headerDesktopHome}>
          <Logo sm link={home.url} />
        </div>
        <div className={css.headerDesktopNav}>
          <div
            id="headerHamburger"
            className={css.headerHamburger}
            onClick={this.toggle}
            onKeyDown={this.toggle}
            role="button"
            tabIndex="0"
            aria-label={mobileNavOpen ? I18n.t('close') : I18n.t('expand_menu')}
          >
            {this.displayToggle()}
          </div>
          <div className={css.headerDesktopNavLinks}>{this.displayLinks()}</div>
        </div>
      </div>
    );
  };

  displayMobile = () => {
    const { mobileOnly, profile } = this.props;
    return (
      <div id="headerMobile" className={css.headerMobileNav}>
        <div>
          {profile ? <HeaderProfile profile={profile} /> : null}
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
