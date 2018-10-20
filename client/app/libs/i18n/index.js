// @flow
import Cookies from 'js-cookie';
import { translations } from './translations';

type Options = {
  [key: string]: string,
};

const missingResult = (locale: string, scope: string): string =>
  // eslint-disable-next-line implicit-arrow-linebreak
  `[missing "${locale}.${scope}" translation]`;

const getValue = (options, option) => {
  const key = option.slice(1, option.length - 1);
  if (key && typeof options !== 'undefined' && options[key]) {
    return options[key];
  }
  return `[missing ${option} value]`;
};

export const I18n = {
  t: (scope: string, options?: Options): string => {
    const locale = Cookies.get('locale') || 'en';
    let result = translations[locale][scope] || missingResult(locale, scope);
    const resultOptions = result.match(/{.*}/g);
    if (resultOptions) {
      resultOptions.forEach((option: string) => {
        result = result.replace(option, getValue(options, option));
      });
    }
    return result;
  },
};
