import React from 'react';
import { storiesOf } from '@storybook/react';

import { RadioButton } from '../components/RadioButton/index';
import { RadioButtonGroup } from '../components/RadioButton/RadioButtonGroup';

storiesOf('RadioButton', module).add('RadioButton', () => (
  <div>
    <h2>One RadioButtonGroup</h2>
    <RadioButtonGroup>
      <RadioButton id="radioButton-one" label="Option 1" checked />
      <RadioButton id="radioButton-two" label="Option 2" checked />
      <RadioButton id="radioButton-three" label="Option 3" />
    </RadioButtonGroup>
  </div>
));
