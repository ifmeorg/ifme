// @flow
import { render } from 'enzyme';
import React from 'react';
import MomentCardSettings from '../MomentCardSettings';

describe('MomentCardSettings', () => {
  it('renders MomentCard setting', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<MomentCardSettings
        cardType="Normal"
        viewersText="Viewers"
      />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
