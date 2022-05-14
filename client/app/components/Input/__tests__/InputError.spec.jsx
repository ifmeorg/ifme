// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { InputError } from 'components/Input/InputError';

describe('InputError', () => {
  it('does not render an error', () => {
    render(<InputError />);
    expect(screen.queryByRole('alert')).not.toBeInTheDocument();
  });

  describe('has empty error', () => {
    it('renders the correct error message', () => {
      render(<InputError error="true" />);
      expect(
        screen.getByText('This field cannot be empty!'),
      ).toBeInTheDocument();
    });
  });

  describe('has a min error', () => {
    it('renders the correct error message', () => {
      render(<InputError error="true" min={0} />);
      expect(
        screen.getByText('This field must be equal or greater than 0!'),
      ).toBeInTheDocument();
    });
  });

  describe('has a max error', () => {
    it('renders the correct error message', () => {
      render(<InputError error="true" max={2} />);
      expect(
        screen.getByText('This field must be equal or less than 2!'),
      ).toBeInTheDocument();
    });
  });

  describe('has a min and max error', () => {
    it('renders the correct error message', () => {
      render(<InputError error="true" min={0} max={2} />);
      expect(
        screen.getByText(
          'This field must be equal or greater than 0 and equal or less than 2!',
        ),
      ).toBeInTheDocument();
    });
  });
});
