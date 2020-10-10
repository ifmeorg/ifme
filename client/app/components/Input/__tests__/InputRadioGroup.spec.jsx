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
    const radioGroup = screen.getByRole('radiogroup');
    expect(radioGroup).toBeInTheDocument();
    const defaultOption = screen.getByRole('radio', { name: `${value}` });
    expect(defaultOption).toBeInTheDocument();
    expect(defaultOption.defaultChecked).toEqual(true);
  });
});
