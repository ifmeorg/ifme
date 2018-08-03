import { render } from 'enzyme';
import React from 'react';
import Header from '../Header';

describe('Header', () => {
  it('renders the Header (not logged in)', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<Header />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });


  it('renders the Header (logged in)', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<Header isLoggedIn />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
