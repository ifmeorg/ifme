/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import { Resource } from 'components/Resource';

const tags = [
  'open_source',
  'tech_industry',
  'free',
  'workplace',
  'podcast',
  'books',
];

export default {
  title: 'Components/Resource',
  component: Resource,
};

const Template = (args) => <Resource {...args} />;

export const WithTags = Template.bind({});

WithTags.args = {
  tags: tags.concat(tags),
  title: 'LifeSIGNS: Self Injury Guidance & Network Support (UK)',
  link: 'http://www.lifesigns.org.uk/',
};
WithTags.parameters = {
  backgrounds: { default: 'mulberry' },
};
WithTags.storyName = 'With tags';

export const WithoutTags = Template.bind({});

WithoutTags.args = {
  title: 'A very long title for a resource that should wrap to two lines and then some or not',
  link: 'https://if-me.org',
  author: 'Author with a very very long name that is usually an edge case',
};
WithoutTags.parameters = {
  backgrounds: { default: 'mulberry' },
};
WithoutTags.storyName = 'Without tags';

export const WithAllProps = Template.bind({});

WithAllProps.args = {
  tags: tags.concat(tags),
  title: 'Invisible Illnesses: depression is an ocean, and another measure to consider',
  link: 'https://if-me.org',
  author: 'Desi Rottman',
};
WithAllProps.parameters = {
  backgrounds: { default: 'mulberry' },
};
WithAllProps.storyName = 'With all props';
