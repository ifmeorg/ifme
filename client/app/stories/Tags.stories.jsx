import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Tag from 'bundles/shared/components/Tag';

storiesOf('Tags', module)
  .add('TagGhostXs', withInfo({})(() =>
    <Tag label={'Self-Injury'} />,
  ))
  .add('TagDarkXs', withInfo({})(() =>
    <Tag dark label={'Self-Injury'} />,
  ))
  .add('Tag', withInfo({})(() =>
    <Tag normal label={'Self-Injury'} />,
  ));
