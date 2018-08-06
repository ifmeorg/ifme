// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Header } from '../index';

const component = (
  <Header
    home={{ name: 'Home', url: '/some-path' }}
    links={[
      { name: 'Link 1', url: '/some-path-one' },
      { name: 'Link 2', url: '/some-path-two', dataMethod: 'delete' },
    ]}
  />
);

const wrapper = shallow(component);

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
});
