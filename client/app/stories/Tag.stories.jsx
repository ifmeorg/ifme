/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Tag } from 'components/Tag';

export default {
  title: 'Components/Tag',
  component: Tag,
};

const Template = (args) => <Tag {...args} />;

export const NormalStyle = Template.bind({});

NormalStyle.args = {
  normal: true,
  label: 'Self-Injury',
};
NormalStyle.storyName = 'Normal style';
NormalStyle.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const SecondaryStyle = Template.bind({});

SecondaryStyle.args = {
  secondary: true,
  label: 'Self-Injury',
};
SecondaryStyle.storyName = 'Secondary style';

export const GhostStyle = Template.bind({});

GhostStyle.args = {
  label: 'Self-Injury',
};
GhostStyle.storyName = 'Ghost style';

export const DarkStyle = Template.bind({});

DarkStyle.args = {
  dark: true,
  label: 'Self-Injury',
};
DarkStyle.storyName = 'Dark style';
