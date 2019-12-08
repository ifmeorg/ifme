// @flow
import React from 'react';
import { QuickCreate } from '../../widgets/QuickCreate';
import type { Props as QuickCreateProps } from '../../widgets/QuickCreate';


export const displayQuickCreate = (input: QuickCreateProps) => {
  const {
    id, name, label, placeholder, checkboxes, formProps,
  } = input;
  if (!checkboxes || !name || !label) return null;
  return (
    <div key={id}>
      <QuickCreate
        id={id}
        name={name}
        label={label}
        placeholder={placeholder}
        checkboxes={checkboxes}
        formProps={formProps}
      />
    </div>
  );
};
