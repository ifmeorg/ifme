// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryBy } from 'components/Story/StoryBy';

describe('StoryBy', () => {
  const { getByText } = screen;

  describe('has no options', () => {
    it('renders correctly', () => {
      render(<StoryBy author="Some author" />);
      expect(getByText('Some author')).toBeInTheDocument();
    });
  });
  describe('has all options', () => {
    it('renders correctly', () => {
      render(<StoryBy author="Some author" avatar="/some-url" />);
      expect(getByText('Some author')).toBeInTheDocument();
    });
  });
});
