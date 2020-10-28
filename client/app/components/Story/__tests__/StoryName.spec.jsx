// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryName } from 'components/Story/StoryName';

describe('StoryName', () => {
  const { getByText } = screen;

  it('renders correctly', () => {
    render(<StoryName name="Real Moment" link="some-url" />);
    expect(getByText('Real Moment')).toBeInTheDocument();
  });
});
