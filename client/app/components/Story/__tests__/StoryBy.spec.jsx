// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryBy } from '../StoryBy';

describe('StoryBy', () => {
  describe('has no options', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(<StoryBy author="Some author" />);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });

  describe('has all options', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(
          <StoryBy author={<div>Some author</div>} avatar="/some-url" />,
        );
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });
});
