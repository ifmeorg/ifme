import { addLocaleData } from 'react-intl';
// every locale is an array of various sub locales, that follow the type defined below
// https://github.com/yahoo/react-intl/wiki/API#addlocaledata
/*
  type LocaleData = {
    locale: string,
    [key: string]: any,
  }
 */
import en from 'react-intl/locale-data/en';
import es from 'react-intl/locale-data/es';
import it from 'react-intl/locale-data/it';
import nb from 'react-intl/locale-data/nb';
import nl from 'react-intl/locale-data/nl';
import pt from 'react-intl/locale-data/pt';
import sv from 'react-intl/locale-data/sv';
import vi from 'react-intl/locale-data/vi';

// Initizalize all locales for react-intl.
export const loadLocales = () => {
  addLocaleData([].concat(en, es, it, nb, nl, pt, sv, vi));
};
