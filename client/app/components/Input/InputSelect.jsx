// @flow
import React, { useState } from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretDown } from '@fortawesome/free-solid-svg-icons';
import css from './Input.scss';
import type { Option } from './utils';

export type Props = {
  id: string,
  name?: string,
  ariaLabel?: string,
  label?: string,
  value?: any,
  options: Option[],
  onChange?: Function,
};

export function InputSelect({
  id,
  name,
  options,
  ariaLabel,
  label,
  onChange,
  value: propValue,
}: Props) {
  const [value, setValue] = useState<any>(propValue);

  const toggleValue = (e: SyntheticEvent<HTMLInputElement>) => {
    setValue(e.currentTarget.value);
    if (onChange) {
      onChange(e);
    }
  };

  return (
    <div className={css.select}>
      <div className={css.selectIcon} role="presentation">
        <FontAwesomeIcon icon={faCaretDown} />
      </div>
      <select
        id={id}
        name={name}
        aria-label={label || ariaLabel}
        value={value}
        onChange={toggleValue}
      >
        {options.map((option: Option) => (
          <option id={option.id} value={option.value} key={option.value}>
            {renderHTML(option.label)}
          </option>
        ))}
      </select>
    </div>
  );
}
