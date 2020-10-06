// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { InputMocks } from 'mocks/InputMocks';
import { InputRadioGroup } from 'components/Input/InputRadioGroup';

const {
  id, name, value, options,
} = InputMocks.inputRadioProps;

describe('InputRadioGroup', () => {
  it('sets default radio button to first option', () => {
    render(
      <InputRadioGroup name={name} id={id} value={value} options={options} />,
    );
    expect(screen.getByRole('radiogroup')).toBeInTheDocument();
    const defaultOption = screen.getByRole('radio', { name: `${value}` });
    expect(defaultOption).toBeInTheDocument();
    expect(defaultOption.defaultChecked).toBe(true);
  });
});
