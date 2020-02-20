// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryContainer } from '../StoryContainer';

describe('StoryContainer', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<StoryContainer data={[]} />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
