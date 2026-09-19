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
  it('holds the chart space with a skeleton until the chart loads', async () => {
    const { container } = renderComponent({ chartType: 'Line' });
    const skeleton = container.querySelector('[aria-busy="true"]');
    expect(skeleton).toBeInTheDocument();
    expect(skeleton.firstChild).toHaveStyle({ height: '300px' });
    await waitFor(() => {
      expect(container.querySelector('canvas')).toBeInTheDocument();
    });
    expect(container.querySelector('[aria-busy="true"]')).toBeNull();
  });

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
