import { render } from 'enzyme';
import React from 'react';
import CrisisPrevention from '../index';

describe('CrisisPrevention', () => {
  it('renders the component', () => {
    let wrapper;
    expect(() => {
      wrapper = render(<CrisisPrevention />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
