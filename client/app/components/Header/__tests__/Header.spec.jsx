// @flow
import React from 'react';
import { render, screen, getByRole } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Header from 'components/Header';

function setup(jsx) {
  return {
    user: userEvent.setup(),
    ...render(jsx),
  };
}

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
    setup(component);

    expect(screen.getByRole('banner')).toBeInTheDocument();
    expect(screen.getByRole('navigation')).toBeInTheDocument();
    expect(screen.getByRole('link', { name: /home/i })).toBeInTheDocument();
    expect(screen.getByRole('link', { name: /link 1/i })).toBeInTheDocument();
    expect(screen.getByRole('link', { name: /link 1/i })).toHaveClass(
      'headerActiveLink'
    );
    expect(screen.getByRole('link', { name: /link 2/i })).toBeInTheDocument();
  });

  it('toggles hamburger correctly', async () => {
    const { container, user } = setup(component);
    const hamburger = container.querySelector('#headerHamburger');
    await user.click(hamburger);

    const mobile = container.querySelector('#headerMobile');
    expect(mobile).toBeInTheDocument();

    await user.click(hamburger);
    expect(mobile).not.toBeInTheDocument();
  });

  it('toggles hamburger from keyboard input when expected', async () => {
    const { container, user } = setup(component);
    const hamburger = container.querySelector('#headerHamburger');

    await user.keyboard('{Tab}{Tab}');
    expect(hamburger).toHaveFocus();
    await user.keyboard('{Enter}');
    expect(container.querySelector('#headerMobile')).toBeInTheDocument();
    await user.keyboard('{Enter}');
    expect(container.querySelector('#headerMobile')).not.toBeInTheDocument();
    await user.keyboard('[Space]');
    expect(container.querySelector('#headerMobile')).toBeInTheDocument();
    await user.keyboard('[Space]');
    expect(container.querySelector('#headerMobile')).not.toBeInTheDocument();

    await user.keyboard('{Tab}');
    expect(container.querySelector('#headerMobile')).not.toBeInTheDocument();
  });

  it('traps focus when the mobile navbar is open', async () => {
    const { container, user } = setup(component);
    const hamburger = container.querySelector('#headerHamburger');

    await user.keyboard('{Tab}{Tab}');
    expect(hamburger).toHaveFocus();
    await user.keyboard('{Enter}');
    expect(container.querySelector('#headerMobile')).toBeInTheDocument();

    await user.keyboard('{Tab}');
    expect(screen.getByRole('link', { name: /link 1/i })).toHaveFocus();
    await user.keyboard('{Tab}');
    expect(screen.getByRole('link', { name: /link 2/i })).toHaveFocus();
    await user.keyboard('{Tab}');
    expect(screen.getByRole('link', { name: /home/i })).toHaveFocus();
    await user.keyboard('{Tab}');
    expect(hamburger).toHaveFocus();
    await user.keyboard('{Tab}');
    expect(screen.getByRole('link', { name: /link 1/i })).toHaveFocus();

    // Shift-tab back to the hamburger and close the mobile menu
    await user.keyboard('{Shift>}{Tab}{/Shift}{Enter}');
    expect(container.querySelector('#headerMobile')).not.toBeInTheDocument();
  });
});
