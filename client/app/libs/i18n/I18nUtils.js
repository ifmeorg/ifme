import Cookies from 'js-cookie';

import enYML from 'config/locales/en.yml';

import { defaultLocale } from './default';
import { translations } from './translations';

export const safeGetLocale = () => Cookies.get('locale') || defaultLocale;

export const getMessages = locale => translations[locale];

export const availableLocalesAsMap = enYML.en.languages;

const filterNonLanguage = ([value]) => !['various'].includes(value);

export const availableLocalesAsCodeArray = Object.entries(availableLocalesAsMap)
  .filter(filterNonLanguage) // Exclude non-language text
  .map(([value]) => value)
  .sort((a, b) => a.localeCompare(b));

export const availableLocalesAsSelectOptions = Object.entries(
  availableLocalesAsMap,
)
  .filter(filterNonLanguage) // Exclude non-language text
  .map(([value, label]) => ({ label, value }))
  .sort((a, b) => a.label.localeCompare(b.label));

export { defaultLocale, translations };
