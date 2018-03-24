import React from 'react';
import { withInfo } from '@storybook/addon-info';
import { storiesOf } from '@storybook/react';

import Footer from 'bundles/shared/components/Footer/Footer';

storiesOf('Footer', module)
  .add('View', withInfo({})(() =>
    <Footer />,
  ));
