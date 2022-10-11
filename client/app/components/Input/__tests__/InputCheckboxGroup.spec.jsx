// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputCheckboxGroup } from 'components/Input/InputCheckboxGroup';

const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const idTwo = 'some-other-id';
const nameTwo = 'some-other-name';
const labelTwo = 'Some Other Label';
const someEvent = (hasError) => {
  if (!hasError) return;
  window.alert('Error');
};
const checkboxes = [
  {
    id,
    name,
    label,
    value: 1,
    checked: true,
    uncheckedValue: 0,
  },
  {
    id: idTwo,
    name: nameTwo,
    label: labelTwo,
    value: 2,
  },
];

describe('InputCheckboxGroup', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('has no required prop', () => {
    it('does not call hasError prop when all checkboxes are unchecked', async () => {
      render(
        <InputCheckboxGroup checkboxes={checkboxes} hasError={someEvent} />,
      );
      const checkbox = screen.getByRole('checkbox', { name: label });
      const otherCheckbox = screen.getByRole('checkbox', { name: labelTwo });

      // toggle both checkboxes false
      await userEvent.click(checkbox);

      expect(checkbox).not.toBeChecked();
      expect(otherCheckbox).not.toBeChecked();
      expect(window.alert).not.toHaveBeenCalled();
    });
  });

  describe('has required prop', () => {
    it('does calls hasError prop when all checkboxes are unchecked', async () => {
      render(
        <InputCheckboxGroup
          checkboxes={checkboxes}
          hasError={someEvent}
          required
        />,
      );
      const checkbox = screen.getByRole('checkbox', { name: label });
      const otherCheckbox = screen.getByRole('checkbox', { name: labelTwo });

      // toggle both checkboxes false
      await userEvent.click(checkbox);

      expect(checkbox).not.toBeChecked();
      expect(otherCheckbox).not.toBeChecked();
      expect(window.alert).toHaveBeenCalledWith('Error');
    });
  });
});
