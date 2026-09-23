// @flow
import Cookies from 'js-cookie';

// In browser builds, Rails injects only the current locale's translations via
// window.__I18N__ (see application.html.erb). In the test environment webpack's
// dead-code elimination keeps the require() below; in production/development
// builds the entire isTestEnv branch is stripped at compile time.
const isTestEnv = process.env.NODE_ENV === 'test';
let testTranslations = null;

function getTranslations(locale: string): Object {
  if (!isTestEnv && typeof window !== 'undefined') {
    // eslint-disable-next-line no-underscore-dangle
    return window.__I18N__ || {};
  }
  if (isTestEnv) {
    if (!testTranslations) {
      // eslint-disable-next-line global-require
      testTranslations = require('./translations.json');
    }
    return testTranslations[locale] || {};
  }
  return {};
}

type Options = {
  [key: string]: string,
};

const missingResult = (locale: string, scope: string): string =>
  // eslint-disable-next-line implicit-arrow-linebreak
  `[missing "${locale}.${scope}" translation]`;

const getValue = (options: ?Options, option: string): string => {
  if (option && options != null && options[option]) {
    return options[option];
  }
  return `[missing {${option}} value]`;
};

export const I18n = {
  t: (scope: string, options?: Options): string => {
    const locale = Cookies.get('locale') || 'en';
    const translations = getTranslations(locale);
    let result = translations[scope] || missingResult(locale, scope);
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
