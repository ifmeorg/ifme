// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryDate } from '../StoryDate';

describe('StoryDate', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<StoryDate date="Created 2 Days ago" />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
