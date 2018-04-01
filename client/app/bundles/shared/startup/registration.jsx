// @flow

/**
 * Add components only if needed in current _if me_ application, because
 * this bundle will be loaded in production.
 */
import ReactOnRails from 'react-on-rails';
import { loadLocales } from 'libs/i18n/I18nSetup';

import '../components/_globals.scss';

import Avatar from '../components/Avatar';

loadLocales();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Avatar,
});
