// @flow
import Cookies from 'js-cookie';
import translations from './translations.json';

type Options = {
  [key: string]: string,
};

const missingResult = (locale: string, scope: string): string =>
  // eslint-disable-next-line implicit-arrow-linebreak
  `[missing "${locale}.${scope}" translation]`;

const getValue = (options, option) => {
  if (option && typeof options !== 'undefined' && options[option]) {
    return options[option];
  }
  return `[missing {${option}} value]`;
};

export const I18n = {
  t: (scope: string, options?: Options): string => {
    const locale = Cookies.get('locale') || 'en';
    let result = translations[locale][scope] || missingResult(locale, scope);
    const resultOptions = result.match(/\{(.*?)\}/g);
    if (resultOptions) {
      resultOptions.forEach((option: string) => {
        const optionKey = option.replace('{', '').replace('}', '');
        result = result.replaceAll(option, getValue(options, optionKey));
      });
    }
    return result;
  },
};
