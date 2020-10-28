// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryCategories } from 'components/Story/StoryCategories';

describe('StoryCategories', () => {
  const { getByText } = screen;

  it('renders correctly', () => {
    render(
      <StoryCategories categories={[{ name: 'Family', slug: '/family' }]} />,
    );
    expect(getByText('Family')).toBeInTheDocument();
  });
});
