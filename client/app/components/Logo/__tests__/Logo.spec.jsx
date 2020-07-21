// @flow
import { render } from '@testing-library/react';
import React from 'react';
import { Logo, LogoSolid } from '../index';
import { Props } from '../LogoFactory';

const uri = '/some-path';

// eslint throws error that spreading props is forbidden. But it's a useful technique here, though.
// eslint-disable-next-line react/jsx-props-no-spreading
const getLogo = (options: Props) => render(<Logo {...options} />);
// eslint-disable-next-line react/jsx-props-no-spreading
const getLogoSolid = (options: Props) => render(<LogoSolid {...options} />);

describe('Logo', () => {
  describe('Logo', () => {
    describe('without link', () => {
      it('renders the small size', () => {
        const { container } = getLogo({ sm: true });
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the regular size', () => {
        const { container } = getLogo();
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the large size', () => {
        const { container } = getLogo({ lg: true });
        expect(container.firstChild).not.toBeNull();
      });
    });

    describe('with link', () => {
      it('renders the small size', () => {
        const { container } = getLogo({ sm: true, link: uri });
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the regular size', () => {
        const { container } = getLogo({ link: uri });
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the large size', () => {
        const { container } = getLogo({ lg: true, link: uri });
        expect(container.firstChild).not.toBeNull();
      });
    });
  });

  describe('LogoSolid', () => {
    describe('without link', () => {
      it('renders the small size', () => {
        const { container } = getLogoSolid({ sm: true });
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the regular size', () => {
        const { container } = getLogoSolid();
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the large size', () => {
        const { container } = getLogoSolid({ lg: true });
        expect(container.firstChild).not.toBeNull();
      });
    });

    describe('with link', () => {
      it('renders the small size', () => {
        const { container } = getLogoSolid({ sm: true, link: uri });
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the regular size', () => {
        const { container } = getLogoSolid({ link: uri });
        expect(container.firstChild).not.toBeNull();
      });

      it('renders the large size', () => {
        const { container } = getLogoSolid({ lg: true, link: uri });
        expect(container.firstChild).not.toBeNull();
      });
    });
  });
});
