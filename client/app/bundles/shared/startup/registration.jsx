// @flow

/**
 * Add components only if needed in current _if me_ application, because
 * this bundle will be loaded in production.
 */

import jstz from 'jstimezonedetect';
import ReactOnRails from 'react-on-rails';
import { loadLocales } from 'libs/i18n/I18nSetup';
import '../components/_global.scss';
import Avatar from '../components/Avatar';

window.jstz = jstz;
loadLocales();

// This is how react_on_rails can see the Components in the browser.
ReactOnRails.register({
  Avatar,
});
