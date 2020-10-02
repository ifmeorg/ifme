/**
 * @flow
 * Enzyme samples: https://gist.github.com/richardscarrott/d89b37aff55ccc504193335198e676d1
 */
import { shallow } from 'enzyme';
import React from 'react';
import { ChartControl } from '../ChartControl';

describe('ChartControl', () => {
  // mocked data
  const MOMENTS_TYPE = 'Moments';
  const CATEGORIES_TYPE = 'Categories';
  const MOODS_TYPE = 'Moods';
  const types = [MOMENTS_TYPE, CATEGORIES_TYPE, MOODS_TYPE];
  const data = {
    [MOMENTS_TYPE]: {
      '2013-02-10 00:00:00 -0800': 11,
      '2013-02-11 00:00:00 -0800': 6,
    },
    [CATEGORIES_TYPE]: [
      {
        data: {
          '2013-02-10': 3,
          '2013-02-11': 6,
          '2013-02-12': 13,
        },
        name: 'School',
      },
    ],
    [MOODS_TYPE]: [
      {
        data: {
          '2013-02-10': 2,
          '2013-02-11': 8,
          '2013-02-12': 3,
        },
        name: 'Anxious',
      },
    ],
  };

  it('renders', () => {
    let wrapper = null;
    expect(() => {
      // shallow render only lists the first level of components
      wrapper = shallow(
        <ChartControl
          types={types}
          initialParams={{ type: MOMENTS_TYPE, data }}
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
    expect(wrapper.find('ChartControlButton').length).toEqual(types.length);
    expect(wrapper.find('Chart').length).toEqual(1);
  });

  it('passes the expected data for the selected type', () => {
    const wrapper = shallow(
      <ChartControl
        types={types}
        initialParams={{ type: MOMENTS_TYPE, data }}
      />,
    );

    // query child chart component to get current props
    let chart = wrapper.find('Chart');
    // test initial data passed down to the chart
    expect(chart.prop('data')).toBe(data[MOMENTS_TYPE]);

    // simulate click on ChartControlButton for a specified type
    const typeToTest = types[Math.floor(Math.random() * types.length)];
    const button = wrapper
      .find('ChartControlButton')
      .findWhere((n) => n.prop('type') === typeToTest);
    button.simulate('click');
    wrapper.update();

    // re-sample child chart component to get updated props
    chart = wrapper.find('Chart');
    // check if chart data gets updated
    expect(chart.prop('data')).toBe(data[typeToTest]);
  });
});
