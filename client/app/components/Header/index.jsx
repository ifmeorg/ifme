// @flow
import React, { useState, type Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBars, faTimes } from '@fortawesome/free-solid-svg-icons';
import ReactHtmlParser from 'react-html-parser';
import { Logo } from '../Logo';
import { HeaderProfile } from './HeaderProfile';
import type { Profile, Link } from './types';
import css from './Header.scss';
import { I18n } from '../../libs/i18n';

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

export const Header = ({
  home, links, mobileOnly, profile,
}: Props) => {
  const [mobileNavOpen, setMobileNavOpen] = useState(false);
  const [toggled, setToggled] = useState(true);

  const toggle = (): void => {
    setMobileNavOpen(!mobileNavOpen);
    setToggled(true);
  };

  const displayToggle = (): Node => {
    const body = ((document.body: any): HTMLBodyElement);
    if (toggled && mobileNavOpen) {
      body.classList.add('bodyHeaderOpen');
      return <FontAwesomeIcon icon={faTimes} />;
    }
    body.classList.remove('bodyHeaderOpen');
    return <FontAwesomeIcon icon={faBars} />;
  };

  const displayLinks = (): Node[] => links.map((link: Link) => (
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

  const displayDesktop = (): Node => (
    <div
      className={css.headerDesktop}
      role="navigation"
      aria-label={I18n.t('navigation.main_menu')}
    >
      <div className={css.headerDesktopHome}>
        <Logo sm link={home.url} />
      </div>
      <div className={css.headerDesktopNav}>
        <div
          id="headerHamburger"
          className={css.headerHamburger}
          onClick={toggle}
          onKeyDown={toggle}
          role="button"
          tabIndex="0"
          aria-label={mobileNavOpen ? I18n.t('close') : I18n.t('expand_menu')}
        >
          {displayToggle()}
        </div>
        <div className={css.headerDesktopNavLinks}>{displayLinks()}</div>
      </div>
    </div>
  );

  const displayMobile = (): Node => (
    <div id="headerMobile" className={css.headerMobileNav}>
      <div>
        {profile ? <HeaderProfile profile={profile} /> : null}
        {mobileOnly ? ReactHtmlParser(mobileOnly) : null}
        {displayLinks()}
      </div>
    </div>
  );

  return (
    <header
      id="header"
      className={`${css.header} ${mobileNavOpen ? css.headerMobile : ''}`}
    >
      <div className={`${mobileNavOpen ? css.headerMobileBg : ''}`}>
        {displayDesktop()}
        {mobileNavOpen ? displayMobile() : null}
      </div>
    </header>
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({
  home, links, mobileOnly, profile,
}: Props) => (
  <Header home={home} links={links} mobileOnly={mobileOnly} profile={profile} />
);
