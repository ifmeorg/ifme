// @flow
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputSwitchProps);

describe('InputSwitch', () => {
  it('renders correctly', () => {
    render(component);
    expect(screen.getByRole('switch')).toBeInTheDocument();
    expect(
      screen.getByRole('checkbox', { hidden: true }),
    ).toBeInTheDocument();
  });

  describe('with mouse', () => {
    it('toggles correctly', () => {
      render(component);
      const inputSwitch = screen.getByRole('switch');

      expect(screen.getByRole('checkbox')).not.toBeChecked();

      userEvent.click(inputSwitch);
      expect(screen.getByRole('checkbox')).toBeChecked();

      userEvent.click(inputSwitch);
      expect(screen.getByRole('checkbox')).not.toBeChecked();
    });
  });

  describe('with keyboard', () => {
    it('toggles correctly', () => {
      render(component);
      const inputSwitch = screen.getByRole('switch');

      expect(screen.getByRole('checkbox')).not.toBeChecked();

      fireEvent.focus(inputSwitch);
      fireEvent.keyDown(inputSwitch, { key: 'Enter' });
      expect(screen.getByRole('checkbox')).toBeChecked();

      fireEvent.keyDown(inputSwitch, { key: 'Enter' });
      expect(screen.getByRole('checkbox')).not.toBeChecked();
    });
  });
});
