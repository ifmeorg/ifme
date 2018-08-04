// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Checkbox } from '../index';

const label = 'Hello';
const id = 'some-id';

describe('Checkbox', () => {
  describe('when props.checked is false', () => {
    it('renders checkbox correctly', () => {
      const wrapper = mount(<Checkbox label={label} id={id} />);
      expect(wrapper.state('checked')).toEqual(false);
      expect(wrapper.find('.checkboxLabel').text()).toEqual(label);
    });

    it('toggles correctly', () => {
      const wrapper = mount(<Checkbox label={label} id={id} />);
      const checkbox = wrapper.find('.checkbox');
      checkbox.simulate('click');
      expect(wrapper.state('checked')).toEqual(true);
      checkbox.simulate('click');
      expect(wrapper.state('checked')).toEqual(false);
    });
  });

  describe('when props.checked is true', () => {
    it('renders checkbox correctly', () => {
      const wrapper = mount(<Checkbox label={label} id={id} checked />);
      expect(wrapper.state('checked')).toEqual(true);
      expect(wrapper.find('.checkboxLabel').text()).toEqual(label);
    });

    it('toggles correctly', () => {
      const wrapper = mount(<Checkbox label={label} id={id} checked />);
      const checkbox = wrapper.find('.checkbox');
      checkbox.simulate('click');
      expect(wrapper.state('checked')).toEqual(false);
      checkbox.simulate('click');
      expect(wrapper.state('checked')).toEqual(true);
    });
  });
});
