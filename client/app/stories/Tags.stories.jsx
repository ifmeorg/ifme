import React from 'react';
import { storiesOf } from '@storybook/react';

import Tag from 'bundles/shared/components/Tag';
import { withSource } from './Stories.helper';

storiesOf('Tags', module)
  .add('TagGhostXs', withSource(
    <Tag label={'Self-Injury'} />,
  ))
  .add('TagDarkXs', withSource(
    <Tag dark label={'Self-Injury'} />,
  ))
  .add('Tag', withSource(
    <div style={{ backgroundColor: '#666', padding: '24px' }}>
      <Tag normal label={'Self-Injury'} />
    </div>,
  ));
