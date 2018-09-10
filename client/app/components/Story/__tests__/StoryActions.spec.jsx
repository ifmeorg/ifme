// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryActions } from '../StoryActions';

describe('StoryActions', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <StoryActions
          actions={{
            edit: 'some-url',
            delete: 'bluh',
            viewers: 'blah',
          }}
          link="some-url"
        />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
