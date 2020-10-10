// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import React from 'react';
import { InputLocation } from 'components/Input/InputLocation';

describe('InputLocation', () => {
  describe('has no initialized value', () => {
    it('updates the value of the input', () => {
      render(
        <InputLocation placeholder="Location" apiKey="fakeKey" id="fakeId" />,
      );
      const value = 'Test Location';
      const autocomplete = screen.getByRole('textbox');
      userEvent.type(autocomplete, value);
      expect(autocomplete).toHaveValue(value);
    });
  });

  describe('has an initialized value', () => {
    it('updates the value of the input', () => {
      const initializedValue = 'Hey';
      render(
        <InputLocation
          placeholder="Location"
          apiKey="fakeKey"
          id="fakeId"
          value={initializedValue}
        />,
      );
      const autocomplete = screen.getByDisplayValue(initializedValue);
      expect(autocomplete).toBeInTheDocument();
      userEvent.clear(autocomplete);
      const value = 'Test Location';
      userEvent.type(autocomplete, value);
      expect(autocomplete).toHaveValue(value);
    });
  });
});
