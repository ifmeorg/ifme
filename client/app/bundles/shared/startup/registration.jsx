// @flow
import ReactOnRails from 'react-on-rails';
import { addLocaleData } from 'react-intl';
import en from 'react-intl/locale-data/en';
import es from 'react-intl/locale-data/es';
import it from 'react-intl/locale-data/it';
import nb from 'react-intl/locale-data/nb';
import br from 'react-intl/locale-data/br';
import sv from 'react-intl/locale-data/sv';

import Logo from '../components/Logo';
import Input from '../components/Input';

// Initizalize all locales for react-intl.
addLocaleData([...en, ...es, ...it, ...nb, ...br, ...sv]);

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Logo,
  Input,
});
