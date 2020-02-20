// @flow
import { render } from 'enzyme';
import React from 'react';
import { Logo, LogoSolid } from '../index';

let wrapper = null;
const link = '/some-path';

describe('Logo', () => {
  describe('Logo', () => {
    describe('without link', () => {
      it('renders the small size', () => {
        expect(() => {
          wrapper = render(<Logo sm />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the regular size', () => {
        expect(() => {
          wrapper = render(<Logo />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the large size', () => {
        expect(() => {
          wrapper = render(<Logo lg />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });
    });

    describe('with link', () => {
      it('renders the small size', () => {
        expect(() => {
          wrapper = render(<Logo sm link={link} />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the regular size', () => {
        expect(() => {
          wrapper = render(<Logo link={link} />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the large size', () => {
        expect(() => {
          wrapper = render(<Logo lg link={link} />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });
    });
  });

  describe('LogoSolid', () => {
    describe('without link', () => {
      it('renders the small size', () => {
        expect(() => {
          wrapper = render(<LogoSolid sm />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the regular size', () => {
        expect(() => {
          wrapper = render(<LogoSolid />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the large size', () => {
        expect(() => {
          wrapper = render(<LogoSolid lg />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });
    });

    describe('with link', () => {
      it('renders the small size', () => {
        expect(() => {
          wrapper = render(<LogoSolid sm link={link} />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the regular size', () => {
        expect(() => {
          wrapper = render(<LogoSolid link={link} />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });

      it('renders the large size', () => {
        expect(() => {
          wrapper = render(<LogoSolid lg link={link} />);
        }).not.toThrow();
        expect(wrapper).not.toBeNull();
      });
    });
  });
});
