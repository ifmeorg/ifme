/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Skeleton } from 'components/Skeleton';

export default {
  title: 'Components/Skeleton',
  component: Skeleton,
  parameters: {
    backgrounds: { default: 'white' },
  },
};

const Template = (args) => <Skeleton {...args} />;

export const ChartPlaceholder = Template.bind({});

ChartPlaceholder.args = {
  height: '300px',
};
ChartPlaceholder.storyName = 'Chart placeholder';

export const TextLine = Template.bind({});

TextLine.args = {
  height: '20px',
  width: '60%',
};
TextLine.storyName = 'Text line';
