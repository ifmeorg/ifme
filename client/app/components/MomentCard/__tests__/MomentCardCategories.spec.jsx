// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCardCategories } from '../MomentCardCategories';

describe('MomentCardCategories', () => {
  it('renders MomentCard categories', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <MomentCardCategories category={['FRIENDS', 'FAMILY']} />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
