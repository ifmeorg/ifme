// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputLocation } from '../InputLocation';

describe('InputLocation', () => {
  describe('has no initialized value', () => {
    it('updates the value of the input', () => {
      const wrapper = shallow(
        <InputLocation placeholder="Location" apiKey="fakeKey" id="fakeId" />,
      );
      const value = 'Test Location';
      wrapper
        .find('LocationAutocomplete')
        .simulate('change', { target: { value } });
      expect(wrapper.find('LocationAutocomplete').props().value).toEqual(value);
    });
  });

  describe('has an initialized value', () => {
    it('updates the value of the input', () => {
      const initializedValue = 'Hey';
      const wrapper = shallow(
        <InputLocation
          placeholder="Location"
          apiKey="fakeKey"
          id="fakeId"
          value={initializedValue}
        />,
      );
      expect(wrapper.find('LocationAutocomplete').props().value).toEqual(
        initializedValue,
      );
      const value = 'Test Location';
      wrapper
        .find('LocationAutocomplete')
        .simulate('change', { target: { value } });
      expect(wrapper.find('LocationAutocomplete').props().value).toEqual(value);
    });
  });
});
