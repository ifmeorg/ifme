// @flow
import { render, screen } from '@testing-library/react';
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
    it('toggles correctly', async () => {
      render(component);
      const inputSwitch = screen.getByRole('switch');
      const user = await userEvent.setup();

      expect(screen.getByRole('checkbox')).not.toBeChecked();

      await user.tab();
      expect(inputSwitch).toHaveFocus();
      await user.keyboard('{Enter}');
      expect(screen.getByRole('checkbox')).toBeChecked();

      await user.keyboard('{Enter}');
      expect(screen.getByRole('checkbox')).not.toBeChecked();
    });
  });
});
