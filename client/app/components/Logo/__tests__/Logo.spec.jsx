// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import { Logo, LogoSolid } from 'components/Logo';

describe('Logo', () => {
  describe('Logo', () => {
    describe('without link', () => {
      it('renders the small size', () => {
        render(<Logo sm />);
        expect(screen.getByRole('presentation')).toBeInTheDocument();
      });

      it('renders the regular size', () => {
        render(<Logo />);
        expect(screen.getByRole('presentation')).toBeInTheDocument();
      });

      it('renders the large size', () => {
        render(<Logo lg />);
        expect(screen.getByRole('presentation')).toBeInTheDocument();
      });
    });

    describe('with link', () => {
      it('renders the small size', () => {
        render(<Logo sm link="/some-path" />);
        expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
      });

      it('renders the regular size', () => {
        render(<Logo link="/some-path" />);
        expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
      });

      it('renders the large size', () => {
        render(<Logo lg link="/some-path" />);
        expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
      });
    });
  });

  describe('LogoSolid', () => {
    describe('without link', () => {
      it('renders the small size', () => {
        render(<LogoSolid sm />);
        expect(screen.getByRole('presentation')).toBeInTheDocument();
      });

      it('renders the regular size', () => {
        render(<LogoSolid />);
        expect(screen.getByRole('presentation')).toBeInTheDocument();
      });

      it('renders the large size', () => {
        render(<LogoSolid lg />);
        expect(screen.getByRole('presentation')).toBeInTheDocument();
      });
    });

    describe('with link', () => {
      it('renders the small size', () => {
        render(<Logo sm link="/some-path" />);
        expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
      });

      it('renders the regular size', () => {
        render(<Logo link="/some-path" />);
        expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
      });

      it('renders the large size', () => {
        render(<Logo lg link="/some-path" />);
        expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
      });
    });
  });
});
