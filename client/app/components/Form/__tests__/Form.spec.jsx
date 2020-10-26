// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import Form from 'components/Form';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const getComponent = () => (
  <Form
    action="/fake-action"
    inputs={[
      { ...InputMocks.inputTextProps, required: true },
      InputMocks.inputSelectProps,
      { ...InputMocks.inputCheckboxGroupProps, required: true },
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputSubmitProps,
    ]}
  />
);

describe('Form', () => {
  const { getByRole, queryByRole, getByPlaceholderText } = screen;

  it('it renders properly', () => {
    render(getComponent());
    expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
    expect(
      getByRole('button', { name: 'Some Submit Value' }),
    ).toBeInTheDocument();
  });

  it('has no alert message when textfield has value and submit clicked', () => {
    render(getComponent());
    userEvent.type(getByPlaceholderText('Some Text Placeholder'), 'randomName');
    userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
    expect(queryByRole('alert')).not.toBeInTheDocument();
  });

  it('displays alert message on submit with empty input', () => {
    render(getComponent());
    userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
    expect(getByRole('alert')).toBeInTheDocument();
  });
});
