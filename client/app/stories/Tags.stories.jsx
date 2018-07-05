import React from 'react';
import { storiesOf } from '@storybook/react';

import Tag from 'bundles/shared/components/Tag';

storiesOf('Tags', module)
  .add('TagGhostXs', () => (
    <Tag label={'Self-Injury'} />
  ))
  .add('TagDarkXs', () => (
    <Tag dark label={'Self-Injury'} />
  ))
  .add('Tag', () => (
    <Tag normal label={'Self-Injury'} />
  ));
