// @flow
import React from 'react';
import axios from 'axios';
import Cookies from 'js-cookie';
import { I18n } from '../../libs/i18n';
import { Input } from '../../components/Input';

export type Props = {
  locale: string,
  locales: string[],
};

const options = (locales) => {
  const result = [];
  locales.forEach((locale: string) => {
    result.push({
      label: I18n.t(`languages.${locale}`),
      value: locale,
      id: locale,
    });
  });
  return result;
};

const onChange = (e: SyntheticEvent<HTMLInputElement>) => {
  const { value } = e.currentTarget;
  const previousValue = Cookies.get('locale');
  if (value !== previousValue) {
    Cookies.set('locale', value);
    axios.post('/toggle_locale', { locale: value }).then(() => {
      window.location.reload();
    });
  }
};

export const ToggleLocale = (props: Props) => {
  const { locale, locales } = props;
  return (
    <Input
      id="locale"
      type="select"
      name="locale"
      ariaLabel={I18n.t('language')}
      value={locale}
      options={options(locales)}
      onChange={onChange}
      small
    />
  );
};
