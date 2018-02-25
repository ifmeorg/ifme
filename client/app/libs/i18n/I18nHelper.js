import Cookies from 'js-cookie';

import { translations } from './translations';
import { defaultLocale } from './default';

export const safeGetLocale = () => Cookies.get('locale') || defaultLocale;

export const getMessages = locale => translations[locale];
