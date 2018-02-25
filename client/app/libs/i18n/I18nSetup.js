import { addLocaleData } from 'react-intl';
import en from 'react-intl/locale-data/en';
import es from 'react-intl/locale-data/es';
import it from 'react-intl/locale-data/it';
import nb from 'react-intl/locale-data/nb';
import sv from 'react-intl/locale-data/sv';
import nl from 'react-intl/locale-data/nl';

// import { translations } from './translations';

// Initizalize all locales for react-intl.
// eslint-disable-next-line import/prefer-default-export
export const loadLocales = () => {
  addLocaleData([...en, ...es, ...it, ...nb, ...sv, ...nl]);
};
