/**
 * @flow
 * Enzyme samples: https://gist.github.com/richardscarrott/d89b37aff55ccc504193335198e676d1
 */
import { shallow } from 'enzyme';
import React from 'react';
import { ChartControl } from '../ChartControl';

describe('ChartControl', () => {
  it('renders', () => {
    let wrapper = null;
    expect(() => {
      // shallow render only lists the first level of components
      wrapper = shallow(
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
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
    expect(wrapper.find('ChartControlButton').length).toEqual(1);
    expect(wrapper.find('Chart').length).toEqual(1);
  });

  it('passes down the expected data for the selected type', () => {
    const data = {
      Moments: {
        '2013-02-10 00:00:00 -0800': 11,
        '2013-02-11 00:00:00 -0800': 6,
      },
      Categories: [
        {
          data: {
            '2013-02-10': 3,
            '2013-02-11': 6,
            '2013-02-12': 13,
          },
          name: 'School',
        },
      ],
    };

    const initialType = 'Moments';
    const wrapper = shallow(
      <ChartControl
        types={['Moments', 'Categories']}
        initialParams={{
          type: initialType,
          data,
        }}
      />,
    );

    // query child chart component to get current props
    let chart = wrapper.find('Chart');
    // test initial data passed down to the chart
    expect(chart.prop('data')).toBe(data[initialType]);

    const targetType = 'Categories';
    // simulate click on ChartControlButton for a specified type
    const button = wrapper
      .find('ChartControlButton')
      .findWhere((n) => n.prop('type') === targetType);
    button.simulate('click');
    wrapper.update();

    // re-sample child chart component to get updated props
    chart = wrapper.find('Chart');
    // check if chart data gets updated
    expect(chart.prop('data')).toBe(data[targetType]);
  });
});
