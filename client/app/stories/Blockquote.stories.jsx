import React from 'react';
import { Blockquote } from '../components/Blockquote';
import { mulberry } from '../../.storybook/backgrounds';

export default {
  title: 'Components/Blockquote',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const Default = () => (
  <Blockquote
    text="It's not just all in your head, it's all around you. We can heal together."
    author="❤️"
  />
);
