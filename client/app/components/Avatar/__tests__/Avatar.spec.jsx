// @flow
import { mount, render } from 'enzyme';
import React from 'react';
import { Avatar } from '../index';

const FILENAME = 'NonExistent.jpg';
const NAME = 'Julia Nguyen';

describe('Avatar', () => {
  it('renders with source only', () => {
    let wrapper = null;

    expect(() => {
      wrapper = render(<Avatar src={FILENAME} />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });

  it('renders with name prop but does not display it', () => {
    const component = <Avatar src={FILENAME} name={NAME} />;
    let wrapper = null;

    expect(() => {
      wrapper = render(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();

    wrapper = mount(component);
    expect(wrapper.find('.name').exists()).toEqual(false);
    expect(wrapper.text()).not.toEqual(NAME);
  });

  it('renders with name prop and displays it', () => {
    const component = <Avatar src={FILENAME} name={NAME} displayname />;
    let wrapper = null;

    expect(() => {
      wrapper = render(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();

    wrapper = mount(component);
    expect(wrapper.find('.name').exists()).toEqual(true);
    expect(wrapper.text()).toEqual(NAME);
  });
});
