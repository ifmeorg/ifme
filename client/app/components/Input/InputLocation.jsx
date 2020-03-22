// @flow
import React, { useState } from 'react';
import LocationAutocomplete from 'location-autocomplete';
import css from './Input.scss';

export type Props = {
  label: string,
  apiKey: string,
  id: string,
  name: string,
  value?: any,
};

export function InputLocation({
  label,
  apiKey,
  id,
  name,
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
      name={name}
      googleAPIKey={apiKey}
      onChange={handleChange}
      onDropdownSelect={handleDropdownSelect}
      id={id}
      className={css.location}
      aria-label={label}
      value={address}
    />
  );
}
