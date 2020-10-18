// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Header from 'components/Header';

const component = (
  <Header
    home={{ name: 'Home', url: '/some-path' }}
    links={[
      { name: 'Link 1', url: '/some-path-one', active: true },
      { name: 'Link 2', url: '/some-path-two', dataMethod: 'delete' },
    ]}
  />
);

describe('Header', () => {
  it('renders correctly', () => {
    render(component);

    expect(screen.getByRole('banner')).toBeInTheDocument();
    expect(screen.getByRole('navigation')).toBeInTheDocument();
    expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
    expect(screen.getByRole('link', { name: /link 1/i })).toBeInTheDocument();
    expect(screen.getByRole('link', { name: /link 1/i })).toHaveClass(
      'headerActiveLink',
    );
    expect(screen.getByRole('link', { name: /link 2/i })).toBeInTheDocument();
  });

  it('toggles hamburger correctly', () => {
    const { container } = render(component);
    const hamburger = container.querySelector('#headerHamburger');
    userEvent.click(hamburger);

    const mobile = container.querySelector('#headerMobile');
    expect(mobile).toBeInTheDocument();

    userEvent.click(hamburger);
    expect(mobile).not.toBeInTheDocument();
  });
});
