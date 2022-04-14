// @flow
import React from 'react';
import type { Node } from 'react';
import css from './InputRadioGroup.scss';
import type { Option } from './utils';

export type Props = {
  name?: string,
  options: Option[],
  value?: any,
};

export function InputRadioGroup({
  name,
  options,
  value: propValue,
}: Props): Node {
  return (
    <div role="radiogroup" className={css.wrapper}>
      {options.map((option: Option) => (
        <div key={option.value} className={css.content}>
          <label className={css.label} htmlFor={option.id}>
            {option.value}
            <input
              type="radio"
              id={option.id}
              name={name}
              value={option.value}
              defaultChecked={option.value === propValue}
            />
          </label>
        </div>
      ))}
    </div>
  );
}
