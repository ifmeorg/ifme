// @flow
import { render } from 'enzyme';
import React from 'react';
import Logo from '../Logo';

describe('Logo', () => {
  it('renders the Logo (medium)', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<Logo />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });

  it('renders the Logo (small)', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<Logo size="small" />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
