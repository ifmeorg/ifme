// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { Story } from 'components/Story';

describe('story', () => {
  const { getByText, getByRole } = screen;
  describe('has no options', () => {
    it('renders correctly', () => {
      render(<Story name="Real Moment" link="some-url" />);
      expect(getByText('Real Moment')).toBeInTheDocument();
      expect(getByRole('link')).toBeInTheDocument();
    });
  });
  describe('has all options', () => {
    it('renders correctly', () => {
      render(
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
      expect(getByText('Draft')).toBeInTheDocument();
      expect(getByText('Real Moment')).toBeInTheDocument();
      expect(getByText('Created 2 Days ago')).toBeInTheDocument();
      expect(getByText('Family')).toBeInTheDocument();
      expect(getByText('Friends')).toBeInTheDocument();
      expect(getByText('Nervous')).toBeInTheDocument();
      expect(getByText('Excited')).toBeInTheDocument();
      expect(getByText('Some Person')).toBeInTheDocument();
      expect(getByText('Some Type')).toBeInTheDocument();
      expect(getByText('Edit')).toBeInTheDocument();
      expect(getByText('Delete')).toBeInTheDocument();
      expect(getByText('blah')).toBeInTheDocument();
    });
  });
});
