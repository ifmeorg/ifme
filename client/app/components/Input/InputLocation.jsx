// @flow
import React, { useState } from 'react';
import LocationAutocomplete from 'location-autocomplete';
import { I18n } from '../../libs/i18n';

export type Props = {
  placeholder: string,
  apiKey: string,
  id: string,
  value?: any,
};

export function InputLocation({
  placeholder,
  apiKey,
  id,
  value: defaultAddress,
}: Props) {
  const [address, setAddress] = useState<string>(defaultAddress || '');

  const handleChange = (event: SyntheticInputEvent<HTMLInputElement>) => {
    const newAdress: string = event.target.value;
    setAddress(newAdress);
  };

  const handleDropdownSelect = (event: any) => {
    const newAdress: string = event.input.value;
    setAddress(newAdress);
  };

  return (
    <LocationAutocomplete
      name="user[location]"
      placeholder={placeholder}
      googleAPIKey={apiKey}
      onChange={handleChange}
      onDropdownSelect={handleDropdownSelect}
      className="smallerMarginBottom"
      id={id}
      aria-label={I18n.t('common.form.location')}
      value={address}
    />
  );
}
