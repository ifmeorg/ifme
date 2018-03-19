// @flow
import React from 'react';
import shortid from 'shortid';
import isNil from 'lodash/isNil';
import { getAvailableLocales } from 'libs/i18n/I18nUtils';

import css from './Dropdown.scss';

const defaultLocales = getAvailableLocales();

type Props = {
    locale: string,
    localeList: { [key: string]: string },
    onChange: (e: string) => void,
};

const Dropdown = (variationClassName: string) =>
  ({ locale, localeList, onChange }: Props) => {
    const localeOptions = isNil(localeList) ? defaultLocales : localeList;

    const options = Object.keys(localeOptions).map(key =>
      (<option value={key} key={shortid.generate()} >
        {localeOptions[key]}
      </option>),
    );

    return (
      <div className={`${css.select_dropdown} ${variationClassName}`}>
        {!isNil(locale) ? (
          <select onChange={e => onChange(e.target.value)} value={locale || null}>
            {options}
          </select>
        ) : (
          <select onChange={e => onChange(e.target.value)}>
            {options}
          </select>
        )}
      </div>);
  };

Dropdown.defaultProps = {
  onChange: () => {},
};

export default Dropdown;
