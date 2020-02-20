import React from 'react';
import { storiesOf } from '@storybook/react';
import { Tag } from '../components/Tag';

storiesOf('Tag', module)
  .add('TagNormal', () => <Tag normal label="Self-Injury" />)
  .add('TagSecondary', () => <Tag secondary label="Self-Injury" />)
  .add('TagGhost', () => <Tag label="Self-Injury" />)
  .add('TagDark', () => <Tag dark label="Self-Injury" />);
