import React from 'react';
import { storiesOf } from '@storybook/react';
import { Blockquote } from '../components/Blockquote';

storiesOf('Blockquotes', module).add('Blockquote', () => (
  <Blockquote
    text="It's not just all in your head, it's all around you. We can heal together."
    author="❤️"
  />
));
