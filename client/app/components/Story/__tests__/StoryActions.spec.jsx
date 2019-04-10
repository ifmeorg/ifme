// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryActions } from '../StoryActions';

describe('StoryActions', () => {
  let wrapper = null;
  describe('with create google calendar action', () => {
    it('renders correctly', () => {
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
              add_to_google_cal: {
                link: 'some-url',
                name: 'Add to google calendar',
                dataMethod: 'post',
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

  describe('with remove google calendar action', () => {
    it('renders correctly', () => {
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
              remove_from_google_cal: {
                link: 'some-url',
                name: 'Remove from google calendar',
                dataMethod: 'delete',
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
});
