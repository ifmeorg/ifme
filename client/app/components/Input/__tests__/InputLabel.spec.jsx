// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { InputLabel } from 'components/Input/InputLabel';

const label = 'Some Label';
const info = 'Some Info';

describe('InputLabel', () => {
  it('renders correctly', () => {
    render(
      <InputLabel label={label} required info={info} error htmlFor="id" />,
    );
    expect(screen.getByText(label)).toBeInTheDocument();
  });
});
