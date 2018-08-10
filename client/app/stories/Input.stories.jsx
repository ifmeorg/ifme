import React from 'react';
import { action } from '@storybook/addon-actions';
import { storiesOf } from '@storybook/react';
import { Input } from '../components/Input';

/**
 * I added onChange handler, but the Input component needs to be fixed to invoke it.
 */
storiesOf('Input', module)
  .add('Input Light', () => (
    <Input
      label="Hello"
      placeholder="Placeholder"
      onChange={action('Input.onChange')}
    />
  ))
  .add('Input Dark', () => (
    <Input
      dark
      label="Hello"
      placeholder="Placeholder"
      onChange={action('Input[dark].onChange')}
    />
  ))
  .add('Input Light (Large)', () => (
    <Input
      large
      label="Hello"
      placeholder="Placeholder"
      onChange={action('Input[large].onChange')}
    />
  ))
  .add('Input Dark (Large)', () => (
    <Input
      dark
      large
      label="Hello"
      placeholder="Placeholder"
      onChange={action('Input[dark][large].onChange')}
    />
  ));
