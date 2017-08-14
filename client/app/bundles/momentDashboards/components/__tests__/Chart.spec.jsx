import { render } from 'enzyme';
import React from 'react';
import Chart from '../Chart';

describe('Chart', () => {
  it('renders a Chart with Canvas', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<Chart xtitle="foo" ytitle="bar" data={{ '2013-02-10 00:00:00 -0800': 11, '2013-02-11 00:00:00 -0800': 6 }} />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
