// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryMoods } from '../StoryMoods';

describe('StoryMoods', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <StoryMoods moods={['NERVOUS', 'ANXIOUS', 'HELPFUL']} />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
