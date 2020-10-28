// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryDate } from 'components/Story/StoryDate';

describe('StoryDate', () => {
  const { getByText, debug } = screen;

  it('renders correctly', () => {
    render(<StoryDate date="Created 2 Days ago" />);
    expect(getByText('Created 2 Days ago')).toBeInTheDocument();
    debug();
  });
});
