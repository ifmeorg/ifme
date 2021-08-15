// @flow
import React, { useState } from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretUp, faCaretDown} from '@fortawesome/free-solid-svg-icons';
import css from './InputMultiSelect.scss';
import Input from 'components/Input';
import type { Option } from './utils';

export type Props = {
  id: string,
  name?: string,
  ariaLabel?: string,
  label?: string,
  value?: any,
  onChange?: Function,
};

export function InputMultiSelect({
  id,
  name,
  options,
  ariaLabel,
  label,
  value: propValue,
}: Props) {
  const [value, setValue] = useState<any>([]);
  const [opened, setOpened] = useState<any>(false);

  const toggleValue = (e: SyntheticEvent<HTMLInputElement>) => {
    const checkeds = e.target.closest(`.${css.panel}`).querySelectorAll('input:checked');
    let actualValues = [];

    checkeds.forEach(check => {
      actualValues.push(check.value);
    });
    setValue(actualValues);
  };

  const checkChild = (e: SyntheticEvent<HTMLInputElement>) => {
    let checkBox = e.target.closest(`.${css.checkMultiSelect}`).querySelector('[type=checkbox]');
    if (e.target.type !== 'checkbox') checkBox.checked = !checkBox.checked;
    toggleValue(e);
  };

  const toggleOpen = () => {
    setOpened(!opened);
  };

  return (
    <>
      <input type='hidden' value={value} name={name} id={id} role='componentValue'></input>
      <button
        className={`${css.buttonL} ${css.fullWidth}`}
        type='button'
        onClick={toggleOpen}
      >
        {label || ariaLabel} <FontAwesomeIcon icon={opened ? faCaretUp : faCaretDown }/>
      </button>
      <div className={css.panelParent}>
        <div className={`${css.panel} ${opened ? '' : css.hidden}`}>
          {options.map((option) => (
            <span key={option.label} className={css.checkMultiSelect} onClick={checkChild}>
              <Input
                dark
                id={option.id}
                label={option.label}
                large
                name={option.id}
                type='checkbox'
                uncheckedValue={0}
                value={option.value}
              />
            </span>
          ))}
        </div>
      </div>
    </>
  );
}
