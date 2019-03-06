// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryContainer } from '../index';

describe('StoryContainer', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <StoryContainer
          data={[]}
        />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
