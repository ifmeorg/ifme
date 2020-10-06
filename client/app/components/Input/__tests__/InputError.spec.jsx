// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { InputError } from 'components/Input/InputError';

describe('InputError', () => {
  it('renders correctly when error does not exist', () => {
    render(<InputError />);
    expect(screen.queryByRole('alert')).not.toBeInTheDocument();
  });

  it('renders correctly when error exists', () => {
    render(<InputError error="true" />);
    expect(screen.getByRole('alert')).toBeInTheDocument();
  });
});
