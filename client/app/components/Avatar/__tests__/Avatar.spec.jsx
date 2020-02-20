// @flow
import { mount, render } from 'enzyme';
import React from 'react';
import { Avatar } from '../index';

const name = 'Julia Nguyen';
const src = '/some-img-url';

describe('Avatar', () => {
  describe('has src prop', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(<Avatar src={src} />);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });

    it('renders correctly with name prop', () => {
      const component = <Avatar src={src} name={name} />;
      let wrapper = null;
      expect(() => {
        wrapper = render(component);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
      wrapper = mount(component);
      expect(wrapper.find('.name').exists()).toEqual(true);
      expect(wrapper.text()).toEqual(name);
    });
  });

  describe('has no src prop', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(<Avatar />);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });

    it('renders correctly with name prop', () => {
      const component = <Avatar name={name} />;
      let wrapper = null;
      expect(() => {
        wrapper = render(component);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
      wrapper = mount(component);
      expect(wrapper.find('.name').exists()).toEqual(true);
      expect(wrapper.text()).toEqual(name);
    });
  });
});
