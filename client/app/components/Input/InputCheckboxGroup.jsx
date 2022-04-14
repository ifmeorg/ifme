// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { InputCheckbox } from 'components/Input/InputCheckbox';
import type { Checkbox } from './utils';

export type Props = {
  checkboxes: Checkbox[],
  required?: boolean, // At least one checkbox must be checked
  hasError?: (errorPresent: boolean) => void,
};

export function InputCheckboxGroup({
  hasError,
  required,
  checkboxes: defaultCheckboxes,
}: Props): Node {
  const [checkboxes, setCheckboxes] = useState<Checkbox[]>(defaultCheckboxes);

  const handleOnChange = (checkbox: { checked: boolean, id: string }) => {
    const newCheckboxes = checkboxes.map((item: Checkbox) => {
      const newItem = { ...item };
      if (newItem.id === checkbox.id) {
        newItem.checked = checkbox.checked;
      }
      return newItem;
    });
    if (required && hasError) {
      hasError(newCheckboxes.filter((item) => item.checked).length === 0);
    }
    setCheckboxes(newCheckboxes);
  };

  return (
    <div>
      {checkboxes.map((checkbox: Checkbox) => (
        <InputCheckbox
          id={checkbox.id}
          name={checkbox.name}
          key={checkbox.id}
          value={checkbox.value}
          checked={checkbox.checked}
          uncheckedValue={checkbox.uncheckedValue}
          label={checkbox.label}
          onChange={handleOnChange}
        />
      ))}
    </div>
  );
}
