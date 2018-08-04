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

// TODO: Figure how to resize window for Jasmine + React tests, might have to switch to Jest
describe('Header', () => {
  it('renders correctly', () => {
    expect(wrapper.length).toEqual(1);
  });
});
