// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import { InputMultiSelect } from 'components/Input/InputMultiSelect';

describe('InputMultiSelect', () => {
  const {
    id, name, label, checkboxes,
  } = InputMocks.inputMultiSelectProps;

  it('renders correctly when the component is closed', () => {
    render(
      <InputMultiSelect
        name={name}
        id={id}
        checkboxes={checkboxes}
        label={label}
      />,
    );
    expect(screen.getByRole('button', { value: label })).toBeVisible();
    expect(screen.getByTestId('multiSelectCheckboxes')).not.toBeVisible();
  });

  it('renders correctly when the component is opened', async () => {
    render(
      <InputMultiSelect
        name={name}
        id={id}
        label={label}
        checkboxes={checkboxes}
      />,
    );
    await userEvent.click(screen.getByRole('button', { value: label }));
    expect(screen.getByTestId('multiSelectCheckboxes')).toBeVisible();
  });
});
