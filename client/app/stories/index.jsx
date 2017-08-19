import 'chartjs';
import React from 'react';

import { storiesOf } from '@storybook/react';
// import { action } from '@storybook/addon-actions';

import Chart from '../bundles/momentDashboards/components/Chart';
import ChartControl from '../bundles/momentDashboards/components/ChartControl';

storiesOf('Chart', module)
  .add('Chart Display', () => (
    <Chart title="Sample" data={{ '2013-02-10 00:00:00 -0800': 11, '2013-02-11 00:00:00 -0800': 6 }} />
  ))
  .add('Chart Control', () => (
    <ChartControl
      types={['Moments', 'Categories', 'Moods']}
      initialParams={{
        type: 'Categories',
        data: {
          Categories: { '2013-02-10': 11, '2013-02-11': 6, '2013-02-12': 15 },
          Moods: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 15 },
          Moments: { '2013-02-10': 10, '2013-02-11': 16, '2013-02-12': 2 },
        },
      }}
    />
  ));
