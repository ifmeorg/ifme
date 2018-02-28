// @flow
import ReactOnRails from 'react-on-rails';
import { loadLocales } from 'libs/i18n/I18nSetup';

import Logo from '../components/Logo';
import Input from '../components/Input';
import Textarea from "../components/Textarea";

loadLocales();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Logo,
  Input,
  Input,
  Textarea,
});

