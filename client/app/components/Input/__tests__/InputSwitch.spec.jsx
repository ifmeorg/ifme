// @flow
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputSwitchProps);

describe('InputSwitch', () => {
  it('renders correctly', () => {
    render(component);
    expect(screen.getByRole('switch')).toBeInTheDocument();
    expect(screen.getByRole('checkbox', { hidden: true })).toBeInTheDocument();
  });

  describe('with mouse', () => {
    it('toggles correctly', async () => {
      render(component);
      const inputSwitch = screen.getByRole('switch');

      expect(screen.getByRole('checkbox')).not.toBeChecked();

      await userEvent.click(inputSwitch);
      expect(screen.getByRole('checkbox')).toBeChecked();

      await userEvent.click(inputSwitch);
      expect(screen.getByRole('checkbox')).not.toBeChecked();
    });
  });

  describe('with keyboard', () => {
    it('toggles correctly', () => {
      render(component);
      const inputSwitch = screen.getByRole('switch');

      expect(screen.getByRole('checkbox')).not.toBeChecked();

      /**
       * TODO: Follow up on `await userEvent.type(inputSwitch, '{enter}')` in v12.1.7.
       * Temporarily including `fireEvent` from RTL, for which the switch must have focus first:
       * https://github.com/testing-library/react-testing-library/issues/376#issuecomment-541242684
       */
      fireEvent.focus(inputSwitch);
      fireEvent.keyDown(inputSwitch, { key: 'Enter' });
      expect(screen.getByRole('checkbox')).toBeChecked();

      fireEvent.keyDown(inputSwitch, { key: 'Enter' });
      expect(screen.getByRole('checkbox')).not.toBeChecked();
    });
  });
});
