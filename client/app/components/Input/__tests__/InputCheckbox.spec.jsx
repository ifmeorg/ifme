// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputCheckbox } from '../InputCheckbox';

const id = 'some-id';
const name = 'some-name';
const value = 'Some Value';
const info = 'Some Info';
const label = 'Some Label';
const uncheckedValue = 'Some Other Value';
const someEvent = () => {
  window.alert('Event triggered!');
};

describe('InputCheckbox', () => {
  beforeEach(() => {
    spyOn(window, 'alert');
  });

  describe('has no uncheckedValue prop', () => {
    it('toggles checkbox correctly', () => {
      const wrapper = shallow(
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          checked
          label={label}
          info={info}
          onClick={someEvent}
        />,
      );
      expect(wrapper.find('input').props().value).toEqual(value);
      expect(wrapper.state('checked')).toEqual(true);
      wrapper.find('input').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.state('checked')).toEqual(false);
      wrapper.find('input').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.state('checked')).toEqual(true);
    });
  });

  describe('has a uncheckedValue prop', () => {
    it('has correct interactions', () => {
      const wrapper = shallow(
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          uncheckedValue={uncheckedValue}
          checked
          label={label}
          info={info}
          onClick={someEvent}
        />,
      );
      expect(wrapper.find('input[type="hidden"]').props().value).toEqual(
        uncheckedValue,
      );
      expect(wrapper.find('input[type="checkbox"]').props().value).toEqual(
        value,
      );
      expect(wrapper.state('checked')).toEqual(true);
      wrapper.find('input[type="checkbox"]').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.state('checked')).toEqual(false);
      wrapper.find('input[type="checkbox"]').simulate('click');
      expect(window.alert).toHaveBeenCalled();
      expect(wrapper.state('checked')).toEqual(true);
    });
  });
});
