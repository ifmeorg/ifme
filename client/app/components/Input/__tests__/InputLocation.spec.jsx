// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputLocation } from '../InputLocation';

describe('InputLocation', () => {
  describe('handle location input', () => {
    it('updates the value of the input', () => {
      const wrapper = shallow(
        <InputLocation placeholder="Location" apiKey="fakeKey" />,
      );
      const value = 'Test Location';

      wrapper
        .find('LocationAutocomplete')
        .simulate('change', { target: { value } });

      expect(wrapper.find('LocationAutocomplete').props().value).toEqual(value);
    });
  });
});
