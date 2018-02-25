// @flow
import React from 'react';
import shortid from 'shortid';
import { getMessages, safeGetLocale } from 'libs/i18n/I18nHelper';

import css from './Dropdown.scss';

const curLocale = safeGetLocale();
const messages = getMessages(curLocale);

const options = Object.keys(messages.languages).map(key =>
  (<option value={key} key={shortid.generate()} >
    {messages.languages[key]}
  </option>),
);

export default (variationClassName: string, onChange: (e: SyntheticEvent<HTMLInputElement>) => void,
  locale: string = curLocale) => () => (
  // eslint-disable-next-line react/jsx-indent
  <div className={`${css.select_dropdown} ${variationClassName}`}>
    <select onChange={e => onChange(e.target.value)} value={locale}>
      {options}
    </select>
  </div>
);
