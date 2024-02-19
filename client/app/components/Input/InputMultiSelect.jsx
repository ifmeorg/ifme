// @flow
import React, { useState, useEffect, useRef } from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretUp, faCaretDown} from '@fortawesome/free-solid-svg-icons';
import css from './InputMultiSelect.scss';
import Input from 'components/Input';
import type { Option } from './utils';
import type { Checkbox } from './utils';
import { InputCheckbox } from 'components/Input/InputCheckbox';
import inputCss from './Input.scss';

export type Props = {
  id: string,
  ariaLabel?: string,
  label?: string,
  value?: any,
  checkboxes: Checkbox[],
};

export function InputMultiSelect({
  id,
  checkboxes,
  label
}: Props) {
  const [opened, setOpened] = useState<boolean>(false);
  const ref = useRef(null);

  const handleOnClick = () => {
    setOpened(!opened);
  };

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (ref.current && !ref.current.contains(event.target)) {
        setOpened(false);
      }
    }

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
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
        <div>
          {label}
        </div>
        <div>
          <FontAwesomeIcon icon={opened ? faCaretUp : faCaretDown }/>
        </div>
      </button>
      <div
        data-testid="multiSelectCheckboxes"
        aria-labelledby={id}
        className={css.multiSelectCheckboxesWrapper}
        role="listbox"
        style={{ display: opened ? 'block' : 'none '}}
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
