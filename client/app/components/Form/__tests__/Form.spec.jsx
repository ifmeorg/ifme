import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import { Form } from 'components/Form/index';

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
  test('it renders properly', () => {
    render(getComponent());
    expect(getByPlaceholderText(/Some Text Placeholder/i)).toBeInTheDocument();
    expect(getByText(/submit/i)).toBeInTheDocument();
  });
  test('no alert message when textfield has value and submit clicked', () => {
    render(getComponent());
    userEvent.type(getByPlaceholderText(/Some Text Placeholder/), 'randomName');
    userEvent.click(getByText(/submit/i));
    expect(queryByRole(/alert/i)).not.toBeInTheDocument();
  });
  test('displays alert message on submit with empty input', () => {
    render(getComponent());
    userEvent.click(getByText(/submit/i));
    expect(getByRole(/alert/i)).toBeInTheDocument();
  });
});
