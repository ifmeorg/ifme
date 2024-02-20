// @flow
import React, { useState, useEffect, useRef } from 'react';
import type { Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretUp, faCaretDown } from '@fortawesome/free-solid-svg-icons';
import { InputCheckbox } from 'components/Input/InputCheckbox';
import css from './InputMultiSelect.scss';
import type { Checkbox } from './utils';

export type Props = {
  id: string,
  label?: string,
  checkboxes: Checkbox[],
};

export function InputMultiSelect({ id, checkboxes, label }: Props): Node {
  const [opened, setOpened] = useState<boolean>(false);
  const ref = useRef(null);

  const handleOnClick = () => {
    setOpened(!opened);
  };

  useEffect(() => {
    const handleClickOutside = (event: any) => {
      if (ref.current && !ref.current.contains(event.target)) {
        setOpened(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [ref]);

  return (
    <div ref={ref}>
      <button
        className={`${css.buttonDarkL} ${css.multiSelectButton}`}
        type="button"
        onClick={handleOnClick}
        id={id}
      >
        <div>{label}</div>
        <div>
          <FontAwesomeIcon icon={opened ? faCaretUp : faCaretDown} />
        </div>
      </button>
      <div
        data-testid="multiSelectCheckboxes"
        aria-labelledby={id}
        className={css.multiSelectCheckboxesWrapper}
        role="listbox"
        style={{ display: opened ? 'block' : 'none ' }}
      >
        <div className={css.multiSelectCheckboxes}>
          {checkboxes.map((checkbox) => (
            <InputCheckbox
              id={checkbox.id}
              name={checkbox.name}
              key={checkbox.id}
              value={checkbox.value}
              checked={checkbox.checked}
              uncheckedValue={checkbox.uncheckedValue}
              label={checkbox.label}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
