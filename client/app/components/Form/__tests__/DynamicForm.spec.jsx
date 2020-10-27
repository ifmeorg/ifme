// @flow
import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import DynamicForm from 'components/Form/DynamicForm';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const defaultMockInputs = [
  { ...InputMocks.inputTextProps, required: true },
  InputMocks.inputSelectProps,
  { ...InputMocks.inputCheckboxGroupProps, required: true },
  InputMocks.inputTagProps,
  InputMocks.inputSwitchProps,
  InputMocks.inputSubmitProps,
];

const getMockInputs = (nameValue) => {
  if (nameValue) {
    return [
      {
        id: 'name-id',
        type: 'text',
        name: 'name',
        label: 'Name',
        placeholder: 'Some Name Placeholder',
        info: 'Some Name Info',
        required: true,
      },
      ...defaultMockInputs,
    ];
  }
  return defaultMockInputs;
};

const testOnSubmit = jest.fn();

const getComponent = (options = {}) => {
  const mockInputs = getMockInputs(options.nameValue);
  return (
    <DynamicForm
      nameValue={options.nameValue}
      formProps={{
        action: '/fake-action',
        inputs: mockInputs,
      }}
      onSubmit={testOnSubmit}
    />
  );
};

describe('DynamicForm', () => {
  const { getByRole, getByText, getByPlaceholderText } = screen;

  describe('when name value does not exist', () => {
    it('renders correctly', () => {
      render(getComponent());
      expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
      expect(
        getByRole('button', { name: 'Some Submit Value' }),
      ).toBeInTheDocument();
    });

    it('has no errors when submit is clicked', async () => {
      render(getComponent());
      userEvent.type(getByPlaceholderText('Some Text Placeholder'), 'bye');
      userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      await waitFor(() => {
        expect(testOnSubmit).toHaveBeenCalledTimes(1);
      });
    });

    it('has errors when submit is clicked', async () => {
      render(getComponent());
      userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      await waitFor(() => {
        expect(testOnSubmit).toHaveBeenCalledTimes(1);
      });
      expect(getByRole('alert')).toBeInTheDocument();
    });
  });

  describe('when name value exists', () => {
    it('renders correctly', () => {
      render(getComponent({ nameValue: 'name' }));
      expect(getByText('Name')).toBeInTheDocument();
      expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
      expect(
        getByRole('button', { name: 'Some Submit Value' }),
      ).toBeInTheDocument();
    });

    it('has no errors when submit is clicked', async () => {
      render(getComponent({ nameValue: 'name' }));
      userEvent.type(getByText('Name'), 'hi');
      userEvent.type(getByPlaceholderText('Some Text Placeholder'), 'bye');
      userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      await waitFor(() => {
        expect(testOnSubmit).toHaveBeenCalledTimes(1);
      });
    });

    it('has errors when submit is clicked', async () => {
      render(getComponent({ nameValue: 'name' }));
      userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      await waitFor(() => {
        expect(testOnSubmit).toHaveBeenCalledTimes(1);
      });
      expect(getByRole('alert')).toBeInTheDocument();
    });
  });
});
