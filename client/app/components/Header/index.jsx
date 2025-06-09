// @flow
import React, {
  useState, useRef, useEffect, type Node,
} from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBars, faTimes } from '@fortawesome/free-solid-svg-icons';
import { Utils } from 'utils';
import { I18n } from 'libs/i18n';
import { Logo } from 'components/Logo';
import { HeaderProfile } from 'components/Header/HeaderProfile';
import type { Profile, Link } from './types';
import css from './Header.scss';
import { useFocusTrap } from '../../hooks';
import { ToggleLocale } from '../../widgets/ToggleLocale';


export type Props = {
  home: Link,
  links: Link[],
  mobileOnly?: any,
  profile?: Profile,
};

export type State = {
  mobileNavOpen: boolean,
};

export const Header = ({
  home,
  links,
  mobileOnly,
  profile,
  locale,
  locales,
}: Props): Node => {
  console.log("Locale props:", locale, locales);

  const [mobileNavOpen, setMobileNavOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const navigationRef = useRef(null);

  useFocusTrap(navigationRef, mobileNavOpen);

  const toggle = (): void => {
    setMobileNavOpen((currentNavValue) => !currentNavValue);
  };

  const handleHamburgerKeyDown = (
    event: SyntheticKeyboardEvent<HTMLElement>,
  ): void => {
    // Only toggle the menu if the user presses the Enter key or the space bar
    if (['Enter', ' '].includes(event.key)) {
      /**
       * Prevent the default action to stop scrolling when space is pressed
       */
      event.preventDefault();
      toggle();
    }
  };

  const displayToggle = (): Node => {
    const body = ((document.body: any): HTMLBodyElement);
    if (mobileNavOpen) {
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
      className={`${css.headerDesktop} ${scrolled ? css.headerScroll : ''}`}
      aria-label={I18n.t('navigation.main_menu')}
      role="navigation"
    >
      <div className={css.headerDesktopHome}>
        <Logo sm link={home.url} />
      </div>
      <div className={css.headerDesktopNav}>
        <div
          id="headerHamburger"
          className={css.headerHamburger}
          onClick={toggle}
          onKeyDown={handleHamburgerKeyDown}
          role="button"
          tabIndex="0"
          aria-label={mobileNavOpen ? I18n.t('close') : I18n.t('expand_menu')}
        >
          {displayToggle()}
        </div>
      {!mobileNavOpen && (
        <div className={css.headerDesktopNavLinks}>
          {displayLinks()}
        <div style={{ transform: 'scale(0.88)', transformOrigin: 'left center', marginTop: '-15px'}}>
          <ToggleLocale locale={locale} locales={locales} />
        </div>
        </div>
      )}
      </div>
    </div>
  );

  const displayMobile = (): Node => (
    <div id="headerMobile" className={css.headerMobileNav}>
      <div>
        {profile ? <HeaderProfile profile={profile} /> : null}
        {mobileOnly ? Utils.renderContent(mobileOnly) : null}
        {displayLinks()}
      </div>
    </div>
  );

  useEffect(() => {
    const handleScroll = (event) => {
      if (event.currentTarget.scrollY > 0) {
        setScrolled(true);
      } else {
        setScrolled(false);
      }
    };
    if (!mobileNavOpen) {
      window.addEventListener('scroll', handleScroll);
    }
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, [mobileNavOpen]);

  return (
    <header
      id="header"
      className={`${css.header} ${mobileNavOpen ? css.headerMobile : ''}`}
    >
      <div
        ref={navigationRef}
        className={`${mobileNavOpen ? css.headerMobileBg : ''}`}
        role="menu"
        tabIndex="-1"
      >
        {displayDesktop()}
        {mobileNavOpen ? displayMobile() : null}
      </div>
    </header>
  );
};

export default ({
  home,
  links,
  mobileOnly,
  profile,
  locale,
  locales,
}: Props): Node => (
  <Header
    home={home}
    links={links}
    mobileOnly={mobileOnly}
    profile={profile}
    locale={locale}
    locales={locales}
  />
);