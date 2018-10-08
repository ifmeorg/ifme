// @flow
import React from 'react';
import axios from 'axios';
import Cookies from 'js-cookie';
import { I18n } from '../../libs/i18n';
import { Input } from '../../components/Input';

const EN = 'en';
const ES = 'es';
const NL = 'nl';
const PT_BR = 'pt-BR';
const SV = 'sv';
const IT = 'it';
const NB = 'nb';
const VI = 'vi';

const locales = [
  { label: I18n.t('languages.en'), value: EN, id: EN },
  { label: I18n.t('languages.es'), value: ES, id: ES },
  { label: I18n.t('languages.nl'), value: NL, id: NL },
  { label: I18n.t('languages.pt-BR'), value: PT_BR, id: PT_BR },
  { label: I18n.t('languages.sv'), value: SV, id: SV },
  { label: I18n.t('languages.it'), value: IT, id: IT },
  { label: I18n.t('languages.nb'), value: NB, id: NB },
  { label: I18n.t('languages.vi'), value: VI, id: VI },
];

type Locale = EN | ES | NL | PT_BR | SV | IT | NB | VI;

export type Props = {
  locale: Locale,
};

const handleSignedOut = (locale: Locale, previousLocale: Locale) => {
  if (locale !== previousLocale) {
    window.document.cookie = `locale=${locale}`;
    window.location.reload();
  }
};

const toggleLocale = (locale: Locale, previousLocale: Locale) => {
  axios
    .post('/toggle_locale', { locale })
    .then((response: any) => {
      const { data } = response;
      if (data && data.signed_in_no_reload) {
        Cookies.set('locale', data.signed_in_no_reload);
      } else if (data && data.signed_in_reload) {
        Cookies.set('locale', data.signed_in_reload);
        window.location.reload();
      } else {
        handleSignedOut(locale, previousLocale);
      }
    });
};

const onChange = (e: SyntheticEvent<HTMLInputElement>) => {
  const { value } = e.currentTarget;
  const previousValue = Cookies.get('locale');
  Cookies.set('locale', value);
  toggleLocale(value, previousValue);
};

export const ToggleLocale = (props: Props) => {
  const { locale } = props;
  return (
    <div aria-label={I18n.t('language')}>
      <Input
        id="locale"
        type="select"
        name="locale"
        value={locale}
        options={locales}
        onChange={onChange}
      />
    </div>
  );
};
