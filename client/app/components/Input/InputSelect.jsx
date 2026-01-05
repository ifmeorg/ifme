// @flow
import { faCaretDown } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import type { Node } from 'react';
import React, { useState } from 'react';
import { Utils } from 'utils';
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
  selected?: Boolean;
};

export function InputSelect({
  id,
  name,
  options,
  ariaLabel,
  label,
  onChange,
  value: propValue,
}: Props): Node {
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
          <option id={option.id} value={option.value} key={option.value} selected={option.selected}>
            {Utils.renderContent(option.label)}
          </option>
        ))}
      </select>
    </div>
  );
}
