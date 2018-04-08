// @flow
import React from 'react';
import { getAvailableLocales } from 'libs/i18n/I18nUtils';

import css from './Dropdown.scss';

const defaultLocales = getAvailableLocales();

type Props = {
  locale?: string,
  localeList?: { [key: string]: string },
  onChange: (e: string) => void,
};

const Dropdown = (variationClassName: string) =>
  ({ locale, localeList = defaultLocales, onChange }: Props) => {
    const attr = locale !== null && locale !== undefined ? { value: locale } : {};
    return (
      <div className={`${css.select_dropdown} ${variationClassName}`}>
        <select onChange={e => onChange(e.target.value)} {...attr}>
          {
            Object.keys(localeList).map(
              key => <option value={key} key={key}>{localeList[key]}</option>,
            )
          }
        </select>
      </div>
    );
  };

Dropdown.defaultProps = {
  onChange: () => {},
};

export default Dropdown;
