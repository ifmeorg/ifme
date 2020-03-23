// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryCategories } from '../StoryCategories';

describe('StoryCategories', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <StoryCategories categories={[{ name: 'Family', slug: '/family' }]} />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
