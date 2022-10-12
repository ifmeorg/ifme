/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Blockquote } from 'components/Blockquote';

export default {
  title: 'Components/Blockquote',
  component: Blockquote,
};

const Template = (args) => <Blockquote {...args} />;

export const Default = Template.bind({});

Default.args = {
  text:
    "It's not just all in your head, it's all around you. We can heal together.",
  author: '❤️',
};
Default.parameters = {
  backgrounds: { default: 'mulberry' },
};
