// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryName } from '../StoryName';

describe('StoryName', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<StoryName name="Real Moment" link="some-url" />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
