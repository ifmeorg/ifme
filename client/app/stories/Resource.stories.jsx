import React from 'react';
import { Resource } from '../components/Resource';
import { mulberry } from '../../.storybook/backgrounds';

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
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const WithTags = () => (
  <Resource
    tagged
    tags={tags.concat(tags)}
    title="LifeSIGNS: Self Injury Guidance & Network Support (UK)"
    link="http://www.lifesigns.org.uk/"
  />
);

WithTags.story = {
  name: 'With tags',
};

export const WithoutTags = () => (
  <Resource
    external
    title="A very long title for a resource that should wrap to two lines and then some or not"
    link="www.if-me.org"
    author="Author with a very very long name that is usually an edge case"
  />
);

WithoutTags.story = {
  name: 'Without tags',
};

export const WithAllOptions = () => (
  <Resource
    tagged
    external
    tags={tags.concat(tags)}
    title="Invisible Illnesses: depression is an ocean, and another measure to consider"
    link="www.if-me.org"
    author="Desi Rottman"
  />
);

WithAllOptions.story = {
  name: 'With all options',
};
