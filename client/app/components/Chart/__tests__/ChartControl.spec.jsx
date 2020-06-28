// @flow

import { render } from '@testing-library/react';
import React from 'react';
import { ChartControl } from '../ChartControl';

describe('ChartControl', () => {
  it('renders', () => {
    const { container, getByRole } = render(
      <ChartControl
        types={['Moments']}
        initialParams={{
          type: 'Moments',
          data: {
            Moments: {
              '2013-02-10 00:00:00 -0800': 11,
              '2013-02-11 00:00:00 -0800': 6,
            },
          },
        }}
      />,
    );

    const chartControlBtn = getByRole('button');
    const chart = getByRole('img');

    expect(container.firstChild).not.toBeNull();
    expect(chartControlBtn).toBeInTheDocument();
    expect(chart).toBeInTheDocument();
  });
});
