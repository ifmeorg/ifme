// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputLocation } from '../InputLocation';

// stub out the calls for google
window.google = {
  maps: {
    places: {
      Autocomplete: class {}
    },
    event: {
      addListener: jest.fn()
    }
  }
};

describe('InputLocation', () => {
  describe('handle location input', () => {
    it('updates the value of the input', () => {
      const placeholder = 'Location';
      const wrapper = shallow(<InputLocation placeholder={placeholder}/>,);
      const value = 'Test Location';

      wrapper
        .find('input')
        .simulate('change', { target: { value: value }});

      expect(wrapper.find('input').props().value).toEqual(value);
    });
  });
});
