// @flow
import { render } from 'enzyme';
import React from 'react';
import { Logo, LogoSmall } from '../index';

describe('Logo', () => {
  it('renders the Logo', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<Logo />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });

  it('renders the Logo (small)', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<LogoSmall />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
