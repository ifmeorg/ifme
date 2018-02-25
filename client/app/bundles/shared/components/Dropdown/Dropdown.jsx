// @flow
import React from 'react';
import shortid from 'shortid';
import { getAvailableLocales } from 'libs/i18n/I18nUtils';

import css from './Dropdown.scss';

const availableLocales = getAvailableLocales();

const options = Object.keys(availableLocales).map(key =>
  (<option value={key} key={shortid.generate()} >
    {availableLocales[key]}
  </option>),
);

type Props = {
    onChange: (e: string) => void,
    locale: string,
};

export default (variationClassName: string) => ({ onChange, locale }: Props) => (
  // eslint-disable-next-line react/jsx-indent
  <div className={`${css.select_dropdown} ${variationClassName}`}>
    <select onChange={e => onChange(e.target.value)} value={locale || null}>
      {options}
    </select>
  </div>
);
