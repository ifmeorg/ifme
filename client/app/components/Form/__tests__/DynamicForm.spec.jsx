// @flow
import React from 'react';
import axios from 'axios';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import DynamicForm from 'components/Form/DynamicForm';

// TODO (julianguyen): Include InputTextarea after writing stubs for Pell editor

const defaultMockInputs = [
  { ...InputMocks.inputTextProps, required: true },
  InputMocks.inputSelectProps,
  { ...InputMocks.inputCheckboxGroupProps, required: true },
  InputMocks.inputTagProps,
  InputMocks.inputSwitchProps,
  InputMocks.inputNumberProps,
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

const error = 'Oh no';

const getComponent = (options = {}) => {
  const mockInputs = getMockInputs(options.nameValue);
  return (
    <DynamicForm
      nameValue={options.nameValue}
      formProps={{
        action: '/fake-action',
        inputs: mockInputs,
      }}
      onSubmit={jest.fn()}
    />
  );
};

describe('DynamicForm', () => {
  const { getByRole, getByText, getByPlaceholderText, getByLabelText } = screen;

  describe('when name value does not exist', () => {
    it('renders correctly', () => {
      render(getComponent());
      expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
      expect(
        getByRole('button', { name: 'Some Submit Value' })
      ).toBeInTheDocument();
    });

    describe('for changes on the input with text type', () => {
      it('has no errors when submit is clicked', async () => {
        const axiosPostSpy = jest.spyOn(axios, 'post').mockResolvedValue({});
        render(getComponent());
        await userEvent.type(
          getByPlaceholderText('Some Text Placeholder'),
          'bye'
        );
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy).toBeCalled());
      });

      it('has errors when submit is clicked', async () => {
        const scrollIntoViewMock = jest.fn();
        window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
        const axiosPostSpy = jest
          .spyOn(axios, 'post')
          .mockRejectedValue({ error });
        render(getComponent());
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy()).rejects.toEqual({ error }));
        expect(getByRole('alert')).toBeInTheDocument();
      });
    });

    describe('for changes on the input with number type', () => {
      it('has no errors when submit is clicked', async () => {
        const axiosPostSpy = jest.spyOn(axios, 'post').mockResolvedValue({});
        render(getComponent());
        await userEvent.type(
          getByPlaceholderText('Some Text Placeholder'),
          'bye'
        );
        await userEvent.type(getByLabelText('Some Number Label'), '2');
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy).toBeCalled());
      });

      it('has errors when submit is clicked', async () => {
        const scrollIntoViewMock = jest.fn();
        window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
        const axiosPostSpy = jest
          .spyOn(axios, 'post')
          .mockRejectedValue({ error });
        render(getComponent());
        await userEvent.type(
          getByPlaceholderText('Some Text Placeholder'),
          'bye'
        );
        await userEvent.type(getByLabelText('Some Number Label'), '-1');
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy()).rejects.toEqual({ error }));
        expect(getByRole('alert')).toBeInTheDocument();
      });
    });
  });

  describe('when name value exists', () => {
    it('renders correctly', () => {
      render(getComponent({ nameValue: 'name' }));
      expect(getByText('Name')).toBeInTheDocument();
      expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
      expect(
        getByRole('button', { name: 'Some Submit Value' })
      ).toBeInTheDocument();
    });

    describe('for changes on the input with text type', () => {
      it('has no errors when submit is clicked', async () => {
        const axiosPostSpy = jest.spyOn(axios, 'post').mockResolvedValue({});
        render(getComponent({ nameValue: 'name' }));
        await userEvent.type(getByText('Name'), 'hi');
        await userEvent.type(
          getByPlaceholderText('Some Text Placeholder'),
          'bye'
        );
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy).toBeCalled());
      });

      it('has errors when submit is clicked', async () => {
        const scrollIntoViewMock = jest.fn();
        window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
        const axiosPostSpy = jest
          .spyOn(axios, 'post')
          .mockRejectedValue({ error });
        render(getComponent({ nameValue: 'name' }));
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy()).rejects.toEqual({ error }));
        expect(getByText('This field cannot be empty!')).toBeInTheDocument();
      });
    });

    describe('for changes on the input with number type', () => {
      it('has no errors when submit is clicked', async () => {
        const axiosPostSpy = jest.spyOn(axios, 'post').mockResolvedValue({});
        render(getComponent({ nameValue: 'name' }));
        await userEvent.type(getByText('Name'), 'hi');
        await userEvent.type(
          getByPlaceholderText('Some Text Placeholder'),
          'bye'
        );
        await userEvent.type(getByLabelText('Some Number Label'), '2');
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy).toBeCalled());
      });

      it('has errors when submit is clicked', async () => {
        const scrollIntoViewMock = jest.fn();
        window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
        const axiosPostSpy = jest
          .spyOn(axios, 'post')
          .mockRejectedValue({ error });
        render(getComponent({ nameValue: 'name' }));
        await userEvent.type(
          getByPlaceholderText('Some Text Placeholder'),
          'bye'
        );
        await userEvent.type(getByLabelText('Some Number Label'), '-1');
        await userEvent.click(
          getByRole('button', { name: 'Some Submit Value' })
        );
        await waitFor(() => expect(axiosPostSpy()).rejects.toEqual({ error }));
        expect(
          getByText(
            'This field must be equal or greater than 0 and equal or less than 2!'
          )
        ).toBeInTheDocument();
      });
    });
  });
});
