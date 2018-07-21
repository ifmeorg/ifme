// @flow
import { render } from 'enzyme';
import React from 'react';
import { Chart } from '../index';

describe('Chart', () => {
  it('renders an AreaChart', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <Chart
          xtitle="foo"
          ytitle="bar"
          data={{
            '2013-02-10 00:00:00 -0800': 11,
            '2013-02-11 00:00:00 -0800': 6,
          }}
          chartType={'Area'}
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });

  it('renders a LineChart', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <Chart
          xtitle="foo"
          ytitle="bar"
          data={{
            '2013-02-10 00:00:00 -0800': 11,
            '2013-02-11 00:00:00 -0800': 6,
          }}
          chartType={'Line'}
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
