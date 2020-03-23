// @flow
import { mount } from 'enzyme';
import React from 'react';
import Header from '../index';

const getComponent = () => (
  <Header
    home={{ name: 'Home', url: '/some-path' }}
    links={[
      { name: 'Link 1', url: '/some-path-one', active: true },
      { name: 'Link 2', url: '/some-path-two', dataMethod: 'delete' },
    ]}
  />
);

const wrapper = mount(getComponent());

describe('Header', () => {
  it('renders correctly', () => {
    expect(wrapper.length).toEqual(1);
  });

  it('toggles hamburger correctly', () => {
    wrapper.find('#headerHamburger').simulate('click');
    expect(wrapper.find('#headerMobile').length).toEqual(1);
    wrapper.find('#headerHamburger').simulate('click');
    expect(wrapper.find('#headerMobile').length).toEqual(0);
  });

  it('displays links correctly', () => {
    expect(wrapper.find('.headerLink').length).toEqual(2);
    expect(wrapper.find('.headerActiveLink').length).toEqual(1);
  });
});
