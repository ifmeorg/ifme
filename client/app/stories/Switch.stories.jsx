import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Switch from 'bundles/shared/components/Switch';

storiesOf('Switch', module)
  .add('Switch ON/OFF', withInfo({})(() =>
    <Switch />,
  ));
