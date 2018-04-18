import React from 'react';
import { storiesOf } from '@storybook/react';

import Input from 'bundles/shared/components/Input';

storiesOf('Input', module)
  .add('Input Light', () => (
    <Input label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Dark', () => (
    <Input dark label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Light (Large)', () => (
    <Input large label="Hello" placeholder="Placeholder" />
  ))
  .add('Input Dark (Large)', () => (
    <Input dark large label="Hello" placeholder="Placeholder" />
  ));
