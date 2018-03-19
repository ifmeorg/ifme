import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Avatar from 'bundles/shared/components/Avatar';

storiesOf('Avatar', module)
  .add('With name', withInfo({})(() =>
    (<Avatar
      src={photo}
      alt="Julia Nguyen"
      name="Julia Nguyen"
    />),
  ))
  .add('Without name', withInfo({})(() =>
    (<Avatar
      src={photo}
      alt="Julia Nguyen"
    />),
  ));