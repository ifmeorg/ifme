import React from 'react';
import { storiesOf } from '@storybook/react';
import { Checkbox } from '../components/Checkbox/index';
import { CheckboxGroup } from '../components/Checkbox/CheckboxGroup';

function handleCheckboxClick(allChecked) {
  window.alert(`Here's an example of an action: ${allChecked}`);
}

storiesOf("Checkbox (don't use)", module).add('Checkbox', () => (
  <div>
    <h2>One CheckboxGroup</h2>
    <CheckboxGroup action={allChecked => handleCheckboxClick(allChecked)}>
      <Checkbox label="Option 1" id="checkbox-one" />
      <Checkbox label="Option 2" id="checkbox-two" checked />
    </CheckboxGroup>

    <h2>Two CheckboxGroup</h2>
    <CheckboxGroup action={allChecked => handleCheckboxClick(allChecked)}>
      <Checkbox label="Option 1" id="checkbox-one" />
    </CheckboxGroup>
  </div>
));
