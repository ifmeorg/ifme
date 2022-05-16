// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryActions } from 'components/Story/StoryActions';

describe('storyActions', () => {
  const { getByText } = screen;

  describe('with create google calendar action', () => {
    it('renders correctly', () => {
      render(
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
            viewers: 'testViewer',
            visible: 'testVisible',
          }}
        />,
      );
      expect(getByText('Add to google calendar')).toBeInTheDocument();
      expect(getByText('Edit')).toBeInTheDocument();
      expect(getByText('Delete')).toBeInTheDocument();
      expect(getByText('Report')).toBeInTheDocument();
      expect(getByText('testViewer')).toBeInTheDocument();
      expect(getByText('testVisible')).toBeInTheDocument();
    });
  });
  describe('with remove google calendar action', () => {
    it('renders correctly', () => {
      render(
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
            viewers: 'testViewer',
            visible: 'testVisible',
          }}
        />,
      );
      expect(getByText('Remove from google calendar')).toBeInTheDocument();
      expect(getByText('Edit')).toBeInTheDocument();
      expect(getByText('Delete')).toBeInTheDocument();
      expect(getByText('Report')).toBeInTheDocument();
      expect(getByText('testViewer')).toBeInTheDocument();
      expect(getByText('testVisible')).toBeInTheDocument();
    });
  });
});
