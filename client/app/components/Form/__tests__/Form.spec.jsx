// @flow
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
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
      InputMocks.inputNumberProps,
      InputMocks.inputSubmitProps,
    ]}
  />
);

describe('Form', () => {
  const {
    getByRole,
    queryByRole,
    getByPlaceholderText,
    getByLabelText,
    getByText,
  } = screen;

  it('renders correctly', () => {
    render(getComponent());
    expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
    expect(
      getByRole('button', { name: 'Some Submit Value' }),
    ).toBeInTheDocument();
  });

  describe('for changes on the input with text type', () => {
    it('has no errors when submit is clicked', async () => {
      render(getComponent());
      await userEvent.type(
        getByPlaceholderText('Some Text Placeholder'),
        'randomName',
      );
      await userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      expect(queryByRole('alert')).not.toBeInTheDocument();
    });

    it('has errors when submit is clicked', async () => {
      const { container } = render(getComponent());
      const form = container.querySelector('form');
      const scrollIntoViewMock = jest.fn();
      window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
      // Using fireEvent.submit instead of userEvent.click because jsdom does not fully
      // implement HTMLFormElement.prototype.requestSubmit (used internally by user-event
      // when clicking a submit button). This should be revisited when jsdom adds support,
      // likely after the React 18 upgrade
      await fireEvent.submit(form);
      expect(getByText('This field cannot be empty!')).toBeInTheDocument();
    });
  });

  describe('for changes on the input with number type', () => {
    it('has no errors when submit is clicked', async () => {
      render(getComponent());
      await userEvent.type(
        getByPlaceholderText('Some Text Placeholder'),
        'randomName',
      );
      await userEvent.type(getByLabelText('Some Number Label'), '2');
      await userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      expect(queryByRole('alert')).not.toBeInTheDocument();
    });

    it('has errors when submit is clicked', async () => {
      const { container } = render(getComponent());
      const form = container.querySelector('form');
      const scrollIntoViewMock = jest.fn();
      window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
      await userEvent.type(
        getByPlaceholderText('Some Text Placeholder'),
        'randomName',
      );
      await userEvent.type(getByLabelText('Some Number Label'), '-1');
      // Using fireEvent.submit instead of userEvent.click because jsdom does not fully
      // implement HTMLFormElement.prototype.requestSubmit (used internally by user-event
      // when clicking a submit button). This should be revisited when jsdom adds support,
      // likely after the React 18 upgrade
      await fireEvent.submit(form);
      expect(
        getByText(
          'This field must be equal or greater than 0 and equal or less than 2!',
        ),
      ).toBeInTheDocument();
    });
  });
});
