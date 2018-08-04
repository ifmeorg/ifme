// @flow
import { mount } from 'enzyme/build';
import React from 'react';
import { RadioButton } from '..';

const label = 'Hello';
const id = 'some-id';

describe('RadioButton', () => {
  describe('when props.checked is false', () => {
    it('renders radio button correctly', () => {
      const wrapper = mount(<RadioButton label={label} id={id} />);
      expect(wrapper.state('checked')).toEqual(false);
      expect(wrapper.find('.radioButtonLabel').text()).toEqual(label);
    });

    it('toggles correctly', () => {
      const wrapper = mount(<RadioButton label={label} id={id} />);
      const radioButton = wrapper.find('.radioButton');
      radioButton.simulate('click');
      expect(wrapper.state('checked')).toEqual(true);
      radioButton.simulate('click');
      expect(wrapper.state('checked')).toEqual(true);
    });
  });

  describe('when props.checked is true', () => {
    it('renders RadioButton correctly', () => {
      const wrapper = mount(<RadioButton label={label} id={id} checked />);
      expect(wrapper.state('checked')).toEqual(true);
      expect(wrapper.find('.radioButtonLabel').text()).toEqual(label);
    });

    it('toggles correctly', () => {
      const wrapper = mount(<RadioButton label={label} id={id} checked />);
      const radioButton = wrapper.find('.radioButton');
      radioButton.simulate('click');
      expect(wrapper.state('checked')).toEqual(true);
    });
  });
});
