// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import { Form } from 'components/Form/index';

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
  const {
    getByRole, getByText, queryByRole, getByPlaceholderText,
  } = screen;

  it('it renders properly', () => {
    render(getComponent());
    expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
    expect(getByText('alert')).toBeInTheDocument();
  });

  it('has no alert message when textfield has value and submit clicked', () => {
    render(getComponent());
    userEvent.type(getByPlaceholderText('Some Text Placeholder'), 'randomName');
    userEvent.click(getByText('alert'));
    expect(queryByRole('alert')).not.toBeInTheDocument();
  });

  it('displays alert message on submit with empty input', () => {
    render(getComponent());
    userEvent.click(getByText('alert'));
    expect(getByRole('alert')).toBeInTheDocument();
  });
});
