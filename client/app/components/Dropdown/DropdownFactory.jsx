// @flow
import React from 'react';
import shortid from 'shortid';

import css from './Dropdown.scss';

type Option = {
  key?: string,
  label: string,
  value: any,
};

type Props = {
  onChange?: (event: Event) => any,
  options: Option[],
  value?: any,
};

export const DropdownFactory = (variationClassName: string) => {
  const DropdownComponent = ({
    onChange,
    options,
    value: propValue,
  }: Props) => (
    <select
      className={`${css.dropdown} ${variationClassName}`}
      onChange={onChange}
      value={propValue}
    >
      {options.map(({ key, label, value }: Option) => (
        <option key={key || shortid.generate()} value={value}>
          {label}
        </option>
      ))}
    </select>
  );

  DropdownComponent.defaultProps = {
    onChange: () => {},
    options: [],
    value: undefined,
  };

  return DropdownComponent;
};
