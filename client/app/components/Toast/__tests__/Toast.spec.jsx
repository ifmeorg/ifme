// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Toast } from 'components/Toast';

describe('Toast', () => {
  describe('Toast Type: Alert', () => {
    it('renders correctly', () => {
      render(
        <Toast
        alert='Invalid username or password.'
        appendDashboardClass='true'
        />,
      );
      expect(screen).not.toBeNull();
    });
  });

  describe('Toast Type: Notice', () => {
    it('renders correctly', () => {
      render(
        <Toast
        notice='Login successful.'
        />,
      );
      expect(screen).not.toBeNull();
    });
  });
});
