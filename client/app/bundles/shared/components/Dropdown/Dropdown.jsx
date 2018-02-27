// @flow
import React from 'react';
import shortid from 'shortid';
import { getAvailableLocales } from 'libs/i18n/I18nUtils';

import css from './Dropdown.scss';

const availableLocales = getAvailableLocales();

type Props = {
    onChange: (e: string) => void,
    locale: string,
};

export default (variationClassName: string, localeList: Object = availableLocales) =>
  ({ onChange, locale }: Props) => {
    const options = Object.keys(localeList).map(key =>
      (<option value={key} key={shortid.generate()} >
        {localeList[key]}
      </option>),
    );

    return (
      <div className={`${css.select_dropdown} ${variationClassName}`}>
        <select onChange={e => onChange(e.target.value)} value={locale || null}>
          {options}
        </select>
      </div>);
  };
