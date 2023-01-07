/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Avatar } from 'components/Avatar';
/* eslint-disable import/no-extraneous-dependencies */
import photo from 'app/assets/images/contributors/ingrid_garcia.jpg';

const name = 'Name';

export default {
  title: 'Components/Avatar',
  component: Avatar,
};

const Template = (args) => <Avatar {...args} />;

export const RegularSizeWithImage = Template.bind({});

RegularSizeWithImage.args = { src: photo };
RegularSizeWithImage.storyName = 'Regular size with image';

export const SmallSizeWithImage = Template.bind({});

SmallSizeWithImage.args = { src: photo, small: true };
SmallSizeWithImage.storyName = 'Small size with image';

export const LargeSizeWithImage = Template.bind({});

LargeSizeWithImage.args = { src: photo, large: true };
LargeSizeWithImage.storyName = 'Large size with image';

export const RegularSizeWithNoImage = Template.bind({});

RegularSizeWithNoImage.storyName = 'Regular size with no image';

export const SmallSizeWithNoImage = Template.bind({});

SmallSizeWithNoImage.args = { small: true };
SmallSizeWithNoImage.storyName = 'Small size with no image';

export const LargeSizeWithNoImage = Template.bind({});

LargeSizeWithNoImage.args = { large: true };
LargeSizeWithNoImage.storyName = 'Large size with no image';

export const RegularSizeWithImageAndName = Template.bind({});

RegularSizeWithImageAndName.args = { src: photo, name };
RegularSizeWithImageAndName.storyName = 'Regular size with image and name';

export const SmallSizeWithImageAndName = Template.bind({});

SmallSizeWithImageAndName.args = { src: photo, small: true, name };
SmallSizeWithImageAndName.storyName = 'Small size with image and name';

export const LargeSizeWithImageAndName = Template.bind({});

LargeSizeWithImageAndName.args = { src: photo, large: true, name };
LargeSizeWithImageAndName.storyName = 'Large size with image and name';

export const RegularSizeWithNameAndNoImage = Template.bind({});

RegularSizeWithNameAndNoImage.args = { name };
RegularSizeWithNameAndNoImage.storyName = 'Regular size with name and no image';

export const SmallSizeWithNameAndNoImage = Template.bind({});

SmallSizeWithNameAndNoImage.args = { small: true, name };
SmallSizeWithNameAndNoImage.storyName = 'Small size with name and no image';

export const LargeSizeWithNameAndNoImage = Template.bind({});

LargeSizeWithNameAndNoImage.args = { large: true, name };
LargeSizeWithNameAndNoImage.storyName = 'Large size with name and no image';
