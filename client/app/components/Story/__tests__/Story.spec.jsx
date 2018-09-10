// @flow
import { render } from 'enzyme';
import React from 'react';
import { Story } from '../index';

describe('Story', () => {
  describe('has no options', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(<Story name="Real Moment" link="some-url" />);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });

  describe('has all options', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(
          <Story
            actions={{
              edit: 'some-url',
              delete: 'bluh',
              viewers: 'blah',
            }}
            name="Real Moment"
            link="some-url"
            categories={['FRIENDS', 'FAMILY']}
            moods={['ANXIOUS', 'HELPFUL']}
            date="Created 2 Days ago"
            draft="Draft"
            storyType="Some Type"
            storyBy="Some Person"
          />,
        );
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });
});
