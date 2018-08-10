// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCardName } from '../MomentCardName';

describe('MomentCardName', () => {
  it('renders MomentCard name', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<MomentCardName name="Real Moment" />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
