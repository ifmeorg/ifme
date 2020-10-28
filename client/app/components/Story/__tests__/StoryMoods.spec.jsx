// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryMoods } from 'components/Story/StoryMoods';

describe('StoryMoods', () => {
  const { getByText } = screen;

  it('renders correctly', () => {
    render(<StoryMoods moods={[{ name: 'Nervous', slug: '/nervous' }]} />);
    expect(getByText('Nervous')).toBeInTheDocument();
  });
});
