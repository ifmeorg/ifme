import React from 'react';
import { storiesOf } from '@storybook/react';
import { Tag } from '../components/Tag';

storiesOf('Tag', module)
  .add('TagGhostXs', () => <Tag label={'Self-Injury'} />)
  .add('TagDarkXs', () => <Tag dark label={'Self-Injury'} />)
  .add('Tag', () => <Tag normal label={'Self-Injury'} />);
