// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputDefault } from '../InputDefault';

const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const placeholder = 'Some Placeholder';
const info = 'Some Info';
const someEvent = () => {
  window.alert('Event triggered!');
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
      const value = 'Some value';
      wrapper.find('input').simulate('change', { currentTarget: { value } });
      expect(wrapper.state('value')).toEqual(value);
      wrapper
        .find('input')
        .simulate('change', { currentTarget: { value: '' } });
      expect(wrapper.state('value')).toEqual('');
      expect(window.alert).toHaveBeenCalled();
    });
  });
});
