// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryDraft } from 'components/Story/StoryDraft';

describe('StoryDraft', () => {
  const { getByText } = screen;

  it('renders correctly', () => {
    render(<StoryDraft draft="DRAFT" />);
    expect(getByText('DRAFT')).toBeInTheDocument();
  });
});
