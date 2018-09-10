// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryCategories } from '../StoryCategories';

describe('StoryCategories', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<StoryCategories categories={['FRIENDS', 'FAMILY']} />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
