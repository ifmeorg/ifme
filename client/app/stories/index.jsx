import 'chartjs';
import React from 'react';

import { storiesOf } from '@storybook/react';
// import { action } from '@storybook/addon-actions';

import Chart from '../bundles/momentDashboards/components/Chart';

storiesOf('Charts', module)
  .add('Area Chart Display', () => (
    <Chart data={{ '2013-02-10 00:00:00 -0800': 11, '2013-02-11 00:00:00 -0800': 6 }} />
  ));
