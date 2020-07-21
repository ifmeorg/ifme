// @flow
import { render, fireEvent } from '@testing-library/react';
import React from 'react';
import Header from '../index';

const getComponent = () => render(
  <Header
    home={{ name: 'Home', url: '/some-path' }}
    links={[
      { name: 'Link 1', url: '/some-path-one', active: true },
      { name: 'Link 2', url: '/some-path-two', dataMethod: 'delete' },
    ]}
  />,
);

describe('Header', () => {
  it('renders correctly', () => {
    const { container } = getComponent();
    expect(container.firstChild).not.toBeNull();
  });

  it('toggles hamburger correctly', () => {
    const { container, getByLabelText } = getComponent();
    fireEvent.click(getByLabelText('expand menu'));
    const headerMobile = container.querySelector('#headerMobile');
    expect(headerMobile).toBeInTheDocument();
    fireEvent.click(getByLabelText('close'));
    expect(headerMobile).not.toBeInTheDocument();
  });

  it('displays links correctly', () => {
    const { container } = getComponent();
    expect(container.querySelectorAll('.headerLink').length).toEqual(2);
    expect(container.querySelectorAll('.headerActiveLink').length).toEqual(1);
  });
});
