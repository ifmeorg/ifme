// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { OAuthButton } from 'components/OAuthButton';

describe('OAuthButton', () => {
  describe('Google sign in button', () => {
    it('renders correctly', () => {
      render(
        <OAuthButton
          signIn
          type="google"
          token="token"
          action="/fake-action"
        />,
      );
      expect(screen).not.toBeNull();
    });
  });

  describe('Google sign up button', () => {
    it('renders correctly', () => {
      render(<OAuthButton type="google" token="token" action="/fake-action" />);
      expect(screen).not.toBeNull();
    });
  });

  describe('Facebook sign in button', () => {
    it('renders correctly', () => {
      render(
        <OAuthButton
          type="facebook"
          signIn
          token="token"
          action="/fake-action"
        />,
      );
      expect(screen).not.toBeNull();
    });
  });

  describe('Facebook sign up button', () => {
    it('renders correctly', () => {
      render(
        <OAuthButton type="facebook" token="token" action="/fake-action" />,
      );
      expect(screen).not.toBeNull();
    });
  });
});
