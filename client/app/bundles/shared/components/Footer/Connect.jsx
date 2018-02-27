// @flow
import React from 'react';
import { injectIntl } from 'react-intl';
import { defaultMessages } from 'libs/i18n/default';
import css from './Footer.scss';

type Prop = {
  intl: Object
};

const Connect = injectIntl(({ intl }: Prop) => {
  const { formatMessage } = intl;
  return (
    <ul>
      <h6 className={css.footer_header}>Connect</h6>
      <li><a href="mailto:join.ifme@gmail.com" target="blank">
        {formatMessage(defaultMessages.commonFormEmail)}
      </a></li>
      <li><a href="http://facebook.com/ifmeorg" target="blank">
        {formatMessage(defaultMessages.navigationFacebook)}
      </a></li>
      <li><a href="https://github.com/ifmeorg/ifme" target="blank">
        {formatMessage(defaultMessages.navigationGithub)}
      </a></li>
      <li><a href="https://www.instagram.com/ifmeorg" target="blank">
        {formatMessage(defaultMessages.navigationInstagram)}
      </a></li>
      <li><a href="https://medium.com/ifme" target="blank">
        {formatMessage(defaultMessages.navigationMedium)}
      </a></li>
      <li><a href="https://opencollective.com/ifme" target="blank">
        {formatMessage(defaultMessages.navigationOpencollective)}
      </a></li>
      <li><a href="http://patreon.com/ifme" target="blank">
        {formatMessage(defaultMessages.navigationPatreon)}
      </a></li>
      <li><a href="https://medium.com/feed/ifme" target="blank">
        {formatMessage(defaultMessages.navigationRss)}
      </a></li>
      <li><a href="http://twitter.com/ifmeorg" target="blank">
        {formatMessage(defaultMessages.navigationTwitter)}
      </a></li>
    </ul>
  );
});

export default Connect;
