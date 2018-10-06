import Cookies from 'js-cookie';
import * as I18n from 'i18n-js';
import { translations } from './translations';

export const setup = () => {
  if (!window.I18n && translations) {
    I18n.defaultLocale = 'en';
    I18n.locale = Cookies.get('locale') || 'en';
    I18n.translations = translations;
    window.I18n = I18n;
  }
};
