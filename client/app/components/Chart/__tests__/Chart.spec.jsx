// @flow
import React from 'react';
import { render, waitFor } from '@testing-library/react';
import { Chart } from 'components/Chart/index';

const renderComponent = ({ chartType }) => render(
  <Chart
    xtitle="foo"
    ytitle="bar"
    data={{
      '2013-02-10 00:00:00 -0800': 11,
      '2013-02-11 00:00:00 -0800': 6,
    }}
    chartType={chartType}
  />,
);

describe('Chart', () => {
  it('renders a Line chart', async () => {
    const { container } = renderComponent({ chartType: 'Line' });
    await waitFor(() => {
      expect(container.querySelector('canvas')).toBeInTheDocument();
    });
  });

  it('renders an Area chart', async () => {
    const { container } = renderComponent({ chartType: 'Area' });
    await waitFor(() => {
      expect(container.querySelector('canvas')).toBeInTheDocument();
    });
  });
});
