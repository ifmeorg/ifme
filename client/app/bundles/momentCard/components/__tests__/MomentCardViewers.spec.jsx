// @flow
import { render } from 'enzyme';
import React from 'react';
import MomentCardViewers from '../MomentCardViewers';

describe('MomentCardViewers', () => {
  it('renders MomentCard viewers', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<MomentCardViewers
        viewersText="Viewers"
      />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
