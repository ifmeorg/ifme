// @flow
import ReactOnRails from 'react-on-rails';
import { loadLocales } from 'libs/i18n/I18nSetup';

import '../components/_globals.scss';

import Avatar from '../components/Avatar';
import Input from '../components/Input';
import Logo from '../components/Logo';
import Textarea from '../components/Textarea';

loadLocales();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Avatar,
  Input,
  Logo,
  Textarea,
});
