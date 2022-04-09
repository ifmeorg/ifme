/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Accordion } from 'components/Accordion';

const title = 'Accordions have pianos';
const children = 'Hello';

export default {
  title: 'Components/Accordion',
  component: Accordion,
};

const Template = (args) => <Accordion {...args} />;

export const RegularSizeAndRegularStyle = Template.bind({});

RegularSizeAndRegularStyle.args = { id: 'some_id', title, children };
RegularSizeAndRegularStyle.storyName = 'Regular size and regular style';
RegularSizeAndRegularStyle.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const LargeSizeAndRegularStyle = Template.bind({});

LargeSizeAndRegularStyle.args = {
  id: 'some_id',
  title,
  children,
  large: true,
};
LargeSizeAndRegularStyle.storyName = 'Large size and regular style';
LargeSizeAndRegularStyle.parameters = {
  backgrounds: { default: 'mulberry' },
};

export const RegularSizeAndDarkStyle = Template.bind({});

RegularSizeAndDarkStyle.args = {
  id: 'some_id',
  title,
  children,
  dark: true,
};
RegularSizeAndDarkStyle.storyName = 'Regular size and dark style';

export const LargeSizeAndDarkStyle = Template.bind({});

LargeSizeAndDarkStyle.args = {
  id: 'some_id',
  title,
  children,
  large: true,
  dark: true,
};
LargeSizeAndDarkStyle.storyName = 'Large size and dark style';
