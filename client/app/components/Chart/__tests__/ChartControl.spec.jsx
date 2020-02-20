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
});
