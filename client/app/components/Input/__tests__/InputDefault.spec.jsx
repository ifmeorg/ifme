// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputDefault } from '../InputDefault';

const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const placeholder = 'Some Placeholder';
const info = 'Some Info';
const someEvent = (error: boolean) => {
  window.alert(`Error is ${error}`);
};

describe('InputDefault', () => {
  beforeEach(() => {
    spyOn(window, 'alert');
  });

  describe('has invalid type prop', () => {
    it('does not render', () => {
      const wrapper = shallow(
        <InputDefault
          id={id}
          type="invalid"
          name={name}
          label={label}
          placeholder={placeholder}
          required
          info={info}
          hasError={someEvent}
        />,
      );
      expect(wrapper.find('input').exists()).toEqual(false);
    });
  });

  describe('has valid type prop', () => {
    it('calls hasError prop when value prop is empty', () => {
      const wrapper = shallow(
        <InputDefault
          id={id}
          type="text"
          name={name}
          label={label}
          placeholder={placeholder}
          required
          info={info}
          hasError={someEvent}
        />,
      );
      wrapper
        .find('input')
        .simulate('change', { currentTarget: { value: 'Some Value' } });
      expect(window.alert).toHaveBeenCalledWith('Error is false');
      wrapper
        .find('input')
        .simulate('change', { currentTarget: { value: '' } });
      expect(window.alert).toHaveBeenCalledWith('Error is true');
    });
  });
});
