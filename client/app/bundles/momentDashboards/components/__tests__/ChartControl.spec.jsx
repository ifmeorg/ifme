// Enzyme samples: https://gist.github.com/richardscarrott/d89b37aff55ccc504193335198e676d1
import { shallow } from 'enzyme';
import React from 'react';
import ChartControl from '../ChartControl';


describe('ChartControl', () => {
  it('renders', () => {
    let wrapper = null;
    const onChange = jasmine.createSpy('change');

    expect(() => {
      // shallow render only lists the first level of components
      wrapper = shallow(<ChartControl
        types={['Categories', 'Moments']}
        onChange={onChange}
        initialParams={{
          type: 'Moments',
          aggregateFunc: 'count',
        }}
      />);
      wrapper.setState({
        data: { '2013-02-10 00:00:00 -0800': 11, '2013-02-11 00:00:00 -0800': 6 },
      });
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
    expect(wrapper.find('div').length).toBe(1);
    // one button factoried for each element in types
    expect(wrapper.find('button').length).toBe(2);
    expect(wrapper.find('Chart').length).toBe(1);
  });
});
