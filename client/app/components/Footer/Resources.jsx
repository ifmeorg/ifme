// @flow
import React from 'react';
import { injectIntl } from 'react-intl';
import { defaultMessages } from 'libs/i18n/default';
import css from './Footer.scss';

type Prop = {
  intl: Object,
};

export const Resources = injectIntl(({ intl }: Prop) => {
  const { formatMessage } = intl;
  return (
    <ul>
      <h6 className={css.footer_header}>
        {formatMessage(defaultMessages.navigationResources)}
      </h6>
      <li>
        <a href="/resources?resource=communities">
          {formatMessage(defaultMessages.pagesResourcesCommunities)}
        </a>
      </li>
      <li>
        <a href="/resources?resource=education">
          {formatMessage(defaultMessages.pagesResourcesEducation)}
        </a>
      </li>
      <li>
        <a href="/resources?resource=hotlines">
          {formatMessage(defaultMessages.pagesResourcesHotlines)}
        </a>
      </li>
      <li>
        <a href="/resources?resource=services">
          {formatMessage(defaultMessages.pagesResourcesServices)}
        </a>
      </li>
    </ul>
  );
});
