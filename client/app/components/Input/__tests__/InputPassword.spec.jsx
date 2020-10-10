// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import { InputPassword } from 'components/Input/InputPassword';

const { id, name, label } = InputMocks.inputPasswordProps;

describe('InputPassword', () => {
  it('toggles show password button correctly', () => {
    const component = InputMocks.createInput(InputMocks.inputPasswordProps);
    render(component);

    const input = screen.getByLabelText(label);
    expect(input).toBeInTheDocument();
    expect(input).toHaveAttribute('type', 'password');

    const button = screen.getByRole('button', { name: 'Show password' });
    expect(button).toBeInTheDocument();

    userEvent.click(button);
    expect(input).toHaveAttribute('type', 'text');
    expect(
      screen.getByRole('button', { name: 'Hide password' }),
    ).toBeInTheDocument();
  });

  describe('when input is not required', () => {
    const component = (
      <InputPassword
        id={id}
        name={name}
        label={label}
        hasError={(error) => {
          window.alert(error);
        }}
      />
    );

    beforeEach(() => {
      jest.spyOn(window, 'alert');
    });

    afterEach(() => {
      jest.clearAllMocks();
    });

    describe('on input focus', () => {
      it('has no error', () => {
        render(component);
        const input = screen.getByLabelText(label);
        userEvent.click(input);
        expect(window.alert).not.toHaveBeenCalled();
      });
    });

    describe('on input blur', () => {
      afterEach(() => {
        jest.clearAllMocks();
      });

      it('has an error when there is no value', () => {
        render(component);
        const input = screen.getByLabelText(label);
        userEvent.clear(input);
        userEvent.tab();
        expect(window.alert).not.toHaveBeenCalled();
      });

      it('has no error when there is a value', () => {
        render(component);
        const input = screen.getByLabelText(label);
        userEvent.type(input, 'Some value');
        userEvent.tab();
        expect(window.alert).not.toHaveBeenCalled();
      });
    });
  });

  describe('when input is required', () => {
    const component = (
      <InputPassword
        id={id}
        name={name}
        label={label}
        hasError={(error) => {
          window.alert(error);
        }}
        required
      />
    );

    beforeEach(() => {
      jest.spyOn(window, 'alert');
    });

    afterEach(() => {
      jest.clearAllMocks();
    });

    describe('on input focus', () => {
      it('has no error', () => {
        render(component);
        const input = screen.getByLabelText(label);
        userEvent.click(input);
        expect(window.alert).toHaveBeenCalledWith(false);
      });
    });

    describe('on input blur', () => {
      afterEach(() => {
        jest.clearAllMocks();
      });

      it('has an error when there is no value', () => {
        render(component);
        const input = screen.getByLabelText(label);
        userEvent.clear(input);
        userEvent.tab();
        expect(window.alert).toHaveBeenCalledWith(true);
      });

      it('has no error when there is a value', () => {
        render(component);
        const input = screen.getByLabelText(label);
        userEvent.type(input, 'Some value');
        userEvent.tab();
        expect(window.alert).toHaveBeenCalledWith(false);
      });
    });
  });
});
