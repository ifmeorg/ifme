// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import React from 'react';
import { InputCheckbox } from 'components/Input/InputCheckbox';

const id = 'some-id';
const name = 'some-name';
const value = 'Some Value';
const info = 'Some Info';
const label = 'Some Label';
const uncheckedValue = 'Some Other Value';
const someEvent = (checkbox) => {
  window.alert(`Checkbox ${checkbox.id} is ${checkbox.checked}`);
};

describe('InputCheckbox', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('has no uncheckedValue prop', () => {
    it('toggles checkbox correctly', async () => {
      render(
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          checked
          label={label}
          info={info}
          onChange={someEvent}
        />,
      );
      const checkbox = screen.getByRole('checkbox', { name: label });
      expect(checkbox).toBeChecked();
      await userEvent.click(checkbox);
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is false');
      await userEvent.click(checkbox);
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is true');
    });
  });

  describe('has a uncheckedValue prop', () => {
    it('toggles checkbox correctly', async () => {
      const { container } = render(
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          uncheckedValue={uncheckedValue}
          checked
          label={label}
          info={info}
          onChange={someEvent}
        />,
      );

      // ensures the input for the uncheckedValue is hidden
      expect(screen.queryByRole('input')).not.toBeInTheDocument();
      // Since '@testing-library/react' does not get hidden inputs,
      // it can be queried directly from the container for this test.
      const hiddenInput = container.querySelector('input[type="hidden"]');
      expect(hiddenInput).toHaveValue(uncheckedValue);

      // validates checkbox behavior
      const checkbox = screen.getByRole('checkbox', { name: label });
      expect(checkbox).toBeChecked();
      await userEvent.click(checkbox);
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is false');
      await userEvent.click(checkbox);
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is true');
    });
  });
});
