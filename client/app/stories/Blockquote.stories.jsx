import React from 'react';
import { Blockquote } from 'components/Blockquote';

export default {
  title: 'Components/Blockquote',
  parameters: {
    backgrounds: { default: 'mulberry' },
  },
};

export const Default = () => (
  <Blockquote
    text="It's not just all in your head, it's all around you. We can heal together."
    author="❤️"
  />
);
