// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Toast } from 'components/Toast';

describe('Toast', () => {
  describe('Toast Type: Alert', () => {
    it('renders correctly', () => {
      render(
        <Toast
          alert="Invalid username or password."
          appendDashboardClass="true"
        />,
      );
      expect(screen).not.toBeNull();
    });

    it('closes correctly on button click', () => {
      const { getByRole } = render(
        <Toast
          alert="Invalid username or password."
          appendDashboardClass="true"
        />,
      );

      const toastContent = getByRole('alert');
      const toastBtn = getByRole('button');

      expect(toastContent).toHaveClass('toastElementVisible');
      fireEvent.click(toastBtn);
      expect(toastContent).toHaveClass('toastElementHidden');
    });

    it('closes automatically after 7 seconds', async () => {
      const { getByRole } = render(
        <Toast
          alert="Invalid username or password."
          appendDashboardClass="true"
        />,
      );

      const toastContent = getByRole('alert');
      expect(toastContent).toHaveClass('toastElementVisible');
      await waitFor(() => {
        expect(toastContent).toHaveClass('toastElementHidden');
      }, {timeout: 7000});
    });

  describe('Toast Type: Notice', () => {
    it('renders correctly', () => {
      render(
        <Toast
          notice="Login successful."
        />,
      );
      expect(screen).not.toBeNull();
    });

    it('closes correctly on button click', () => {
      const { getByRole } = render(
        <Toast
          notice="Login successful."
        />,
      );

      const toastContent = getByRole('region');
      const toastBtn = getByRole('button');

      expect(toastContent).toHaveClass('toastElementVisible');
      fireEvent.click(toastBtn);
      expect(toastContent).toHaveClass('toastElementHidden');
    });

    it('closes automatically after 7 seconds', async () => {
      const { getByRole } = render(
        <Toast
          notice="Login successful."
        />,
      );

      const toastContent = getByRole('region');
      expect(toastContent).toHaveClass('toastElementVisible');
      await waitFor(() => {
        expect(toastContent).toHaveClass('toastElementHidden');
      }, {timeout: 7000});
    });
  });

  describe('Toast Type: Notice', () => {
    it('renders correctly', () => {
      render(
        <Toast
          notice="Signed out successfully."
        />,
      );
      expect(screen).not.toBeNull();
    });
  });
});
