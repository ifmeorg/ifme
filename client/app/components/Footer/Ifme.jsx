// @flow
import React from 'react';
import { injectIntl } from 'react-intl';
import { defaultMessages } from 'libs/i18n/default';
import css from './Footer.scss';

type Prop = {
  intl: Object,
};

export const Ifme = injectIntl(({ intl }: Prop) => {
  const { formatMessage } = intl;
  return (
    <ul>
      <h6 className={css.footer_header}>
        {formatMessage(defaultMessages.appName)}
      </h6>
      <li>
        <a href="/about">{formatMessage(defaultMessages.navigationAbout)}</a>
      </li>
      <li>
        <a href="/blog">{formatMessage(defaultMessages.navigationBlog)}</a>
      </li>
      <li>
        <a href="/contribute">
          {formatMessage(defaultMessages.navigationContribute)}
        </a>
      </li>
      <li>
        <a href="/faq">{formatMessage(defaultMessages.navigationFaq)}</a>
      </li>
      <li>
        <a href="/partners">
          {formatMessage(defaultMessages.navigationPartners)}
        </a>
      </li>
      <li>
        <a href="/press">{formatMessage(defaultMessages.navigationPress)}</a>
      </li>
      <li>
        <a href="/privacy">
          {formatMessage(defaultMessages.navigationPrivacy)}
        </a>
      </li>
    </ul>
  );
});
