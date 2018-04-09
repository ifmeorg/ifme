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
import sv from 'react-intl/locale-data/sv';
import nl from 'react-intl/locale-data/nl';
import vn from 'react-intl/locale-data/vn';
import br from 'react-intl/locale-data/br';

const ptbr = br[0];
ptbr.locale = 'ptbr';

// Initizalize all locales for react-intl.
// eslint-disable-next-line import/prefer-default-export
export const loadLocales = () => {
  addLocaleData([...en, ...es, ...it, ...nb, ...sv, ...nl, ...vn, ptbr]);
};
