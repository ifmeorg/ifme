import React from 'react';
import { storiesOf } from '@storybook/react';

import { Heading } from '../components/Heading';

storiesOf('Headings', module)
  .add('Heading Large', () => (
    <Heading
      large
      label={
        'Better Communication with loved ones leads to better mental health.'
      }
    />
  ))
  .add('Heading Normal', () => (
    <Heading label={'A community for mental health experiences.'} />
  ))
  .add('Heading Small', () => (
    <Heading small label={'A community for mental health experiences.'} />
  ))
  .add('Text', () => (
    <Heading
      text
      label={'We need each others support to break down stigmas.'}
    />
  ));
