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
            edit: { link: 'some-url', name: 'Edit' },
            delete: {
              link: 'some-url',
              name: 'Delete',
              dataMethod: 'delete',
              dataConfirm: 'Are you sure?',
            },
            report: { link: 'some-url', name: 'Report' },
            viewers: 'blah',
          }}
        />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
