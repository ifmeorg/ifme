// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCardDate } from '../MomentCardDate';

describe('MomentCardDate', () => {
  it('renders MomentCard date', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<MomentCardDate date="Created 2 Days ago" />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
