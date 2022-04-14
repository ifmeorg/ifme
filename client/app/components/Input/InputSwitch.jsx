// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCheck, faTimes } from '@fortawesome/free-solid-svg-icons';
import { I18n } from 'libs/i18n';
import { Utils } from 'utils';
import { InputCheckbox } from 'components/Input/InputCheckbox';
import css from './InputSwitch.scss';

export type Props = {
  id: string,
  name: string,
  label: string,
  value?: any,
  checked?: boolean,
  uncheckedValue?: any,
};

export type State = {
  checked: boolean,
  key?: string,
};

export function InputSwitch({
  id,
  name,
  label,
  value,
  uncheckedValue,
  checked: propChecked,
}: Props): Node {
  const [checked, setChecked] = useState<boolean>(!!propChecked);
  const [key, setKey] = useState<string>('');

  const toggleChecked = () => {
    setChecked(!checked);
    setKey(Utils.randomString());
  };

  const onKeyDown = (e: SyntheticKeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      toggleChecked();
    }
  };

  const displaySwitchHidden = () => (
    <div className={css.switchHidden}>
      <InputCheckbox
        id={id}
        key={key}
        name={name}
        label={label}
        value={value}
        uncheckedValue={uncheckedValue}
        checked={checked}
      />
    </div>
  );

  const displaySwitchIcon = () => {
    if (checked) {
      return <FontAwesomeIcon icon={faCheck} />;
    }
    return <FontAwesomeIcon icon={faTimes} />;
  };

  const displaySwitch = () => (
    <div
      id={`${id}_switch`}
      className={`switchToggle ${css.switchToggle}`}
      onClick={toggleChecked}
      onKeyDown={onKeyDown}
      role="switch"
      aria-checked={checked}
      tabIndex={0}
      aria-label={checked ? I18n.t('yes_text') : I18n.t('no_text')}
    >
      {displaySwitchIcon()}
    </div>
  );

  return (
    <div className={css.switch}>
      <div
        className={`${css.switchWrapper} ${
          checked ? css.switchOn : css.switchOff
        }`}
      >
        {displaySwitch()}
      </div>
      {displaySwitchHidden()}
    </div>
  );
}
