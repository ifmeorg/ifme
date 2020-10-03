// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryMoods } from 'components/Story/StoryMoods';

describe('StoryMoods', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <StoryMoods moods={[{ name: 'Nervous', slug: '/nervous' }]} />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
