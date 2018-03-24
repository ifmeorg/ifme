import Cookies from 'js-cookie';

import enYML from 'config/locales/en.yml';

import { translations } from './translations';
import { defaultLocale } from './default';

export const safeGetLocale = () => Cookies.get('locale') || defaultLocale;

export const getMessages = locale => translations[locale];

export const getAvailableLocales = () => enYML.en.languages;
