import React from 'react';
import { Tag } from '../components/Tag';
import { mulberry } from '../../.storybook/backgrounds';

export default {
  title: 'Components/Tag',
};

export const TagNormal = () => <Tag normal label="Self-Injury" />;

TagNormal.story = {
  name: 'TagNormal',
  parameters: {
    backgrounds: [{ ...mulberry, default: true }],
  },
};

export const TagSecondary = () => <Tag secondary label="Self-Injury" />;

TagSecondary.story = {
  name: 'TagSecondary',
};

export const TagGhost = () => <Tag label="Self-Injury" />;

TagGhost.story = {
  name: 'TagGhost',
};

export const TagDark = () => <Tag dark label="Self-Injury" />;

TagDark.story = {
  name: 'TagDark',
};
