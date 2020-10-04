// @flow
import { render } from 'enzyme';
import React from 'react';
import { Story } from 'components/Story';

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
              edit: { link: 'some-url', name: 'Edit' },
              delete: {
                link: 'some-url',
                name: 'Delete',
                dataMethod: 'delete',
                dataConfirm: 'Are you sure?',
              },
              viewers: 'blah',
            }}
            name="Real Moment"
            link="some-url"
            categories={[
              { name: 'Family', slug: '/family' },
              { name: 'Friends', slug: '/friends' },
            ]}
            moods={[
              { name: 'Nervous', slug: '/nervous' },
              { name: 'Excited', slug: '/excited' },
            ]}
            date="Created 2 Days ago"
            draft="Draft"
            storyType="Some Type"
            storyBy={{ author: 'Some Person' }}
          />,
        );
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });
});
