import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Logo from 'bundles/shared/components/Logo';

storiesOf('Logo', module)
  .add('Small', withInfo({})(() =>
    <Logo size="small" />,
  ))
  .add('Medium', withInfo({})(() =>
    <Logo />,
  ));
