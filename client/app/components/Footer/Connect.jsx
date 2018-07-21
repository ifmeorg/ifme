// @flow
import React from 'react';
import { injectIntl } from 'react-intl';
import shortid from 'shortid';

import { defaultMessages } from 'libs/i18n/default';

import css from './Footer.scss';

type Prop = {
  intl: Object,
};

const NEW_WINDOW_NAME = '_blank';

const links = [
  [defaultMessages.commonFormEmail, 'mailto:join.ifme@gmail.com'],
  [defaultMessages.navigationFacebook, 'http://facebook.com/ifmeorg'],
  [defaultMessages.navigationGithub, 'http://facebook.com/ifmeorg'],
  [defaultMessages.navigationInstagram, 'https://www.instagram.com/ifmeorg'],
  [defaultMessages.navigationMedium, 'https://medium.com/ifme'],
  [defaultMessages.navigationOpencollective, 'https://opencollective.com/ifme'],
  [defaultMessages.navigationPatreon, 'http://patreon.com/ifme'],
  [defaultMessages.navigationRss, 'https://medium.com/feed/ifme'],
  [defaultMessages.navigationTwitter, 'http://twitter.com/ifmeorg'],
];

export const Connect = injectIntl(({ intl }: Prop) => {
  const { formatMessage } = intl;
  return (
    <ul>
      <h6 className={css.footer_header}>Connect</h6>
      {links.map(([label, url]) => (
        <li key={shortid.generate()}>
          <a href={url} target={NEW_WINDOW_NAME}>
            {formatMessage(label)}
          </a>
        </li>
      ))}
    </ul>
  );
});
