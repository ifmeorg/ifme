// @flow
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import { LoadMoreButton } from 'components/LoadMoreButton';

const onClick = () => undefined;

describe('LoadMoreButton', () => {
  it('renders the button', () => {
    render(<LoadMoreButton onClick={onClick} />);
    expect(screen.getByRole('button')).toBeInTheDocument();
  });
});