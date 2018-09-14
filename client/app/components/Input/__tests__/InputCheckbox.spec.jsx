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
const someEvent = (checkbox) => {
  window.alert(`Checkbox ${checkbox.id} is ${checkbox.checked}`);
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
          onChange={someEvent}
        />,
      );
      expect(wrapper.find('input').props().value).toEqual(value);
      wrapper
        .find('input')
        .simulate('change', { currentTarget: { checked: false } });
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is false');
      wrapper
        .find('input')
        .simulate('change', { currentTarget: { checked: true } });
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is true');
    });
  });

  describe('has a uncheckedValue prop', () => {
    it('toggles checkbox correctly', () => {
      const wrapper = shallow(
        <InputCheckbox
          id={id}
          name={name}
          value={value}
          uncheckedValue={uncheckedValue}
          checked
          label={label}
          info={info}
          onChange={someEvent}
        />,
      );
      expect(wrapper.find('input[type="hidden"]').props().value).toEqual(
        uncheckedValue,
      );
      expect(wrapper.find('input[type="checkbox"]').props().value).toEqual(
        value,
      );
      wrapper
        .find('input[type="checkbox"]')
        .simulate('change', { currentTarget: { checked: false } });
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is false');
      wrapper
        .find('input[type="checkbox"]')
        .simulate('change', { currentTarget: { checked: true } });
      expect(window.alert).toHaveBeenCalledWith('Checkbox some-id is true');
    });
  });
});
