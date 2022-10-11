// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import React from 'react';
import { InputLocation } from 'components/Input/InputLocation';

describe('InputLocation', () => {
  describe('has no initialized value', () => {
    it('updates the value of the input', async () => {
      render(
        <InputLocation placeholder="Location" apiKey="fakeKey" id="fakeId" />
      );
      const value = 'Test Location';
      const autocomplete = screen.getByRole('textbox');
      await userEvent.type(autocomplete, value);
      expect(autocomplete).toHaveValue(value);
    });
  });

  describe('has an initialized value', () => {
    it('updates the value of the input', async () => {
      const initializedValue = 'Hey';
      render(
        <InputLocation
          placeholder="Location"
          apiKey="fakeKey"
          id="fakeId"
          value={initializedValue}
        />
      );
      const autocomplete = screen.getByDisplayValue(initializedValue);
      expect(autocomplete).toBeInTheDocument();
      await userEvent.clear(autocomplete);
      const value = 'Test Location';
      await userEvent.type(autocomplete, value);
      expect(autocomplete).toHaveValue(value);
    });
  });
});
