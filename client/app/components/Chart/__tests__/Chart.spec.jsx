// @flow
import React from 'react';
import { render } from '@testing-library/react';
import { Chart } from '../index';

function getComponent(options) {
  return render(
    <Chart
      xtitle="foo"
      ytitle="bar"
      data={{
        '2013-02-10 00:00:00 -0800': 11,
        '2013-02-11 00:00:00 -0800': 6,
      }}
      chartType={options.chartType}
    />,
  );
}

describe('Chart', () => {
  it('renders an AreaChart', () => {
    const { container } = getComponent({ chartType: 'Area' });
    expect(container.firstChild).not.toBeNull();
  });

  it('renders a LineChart', () => {
    const { container } = getComponent({ chartType: 'Line' });
    expect(container.firstChild).not.toBeNull();
  });
});
