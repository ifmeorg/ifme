// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Chart } from '../index';

function getComponent(options) {
  return shallow(
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
    const wrapper = getComponent({ chartType: 'Area' });
    expect(wrapper.length).toEqual(1);
  });

  it('renders a LineChart', () => {
    const wrapper = getComponent({ chartType: 'Line'});
    expect(wrapper.length).toEqual(1);
  });
});
