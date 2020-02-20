// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputError } from '../InputError';

describe('InputError', () => {
  it('renders correctly when error does not exist', () => {
    const wrapper = shallow(<InputError />);
    expect(wrapper.find('.labelError').exists()).toEqual(false);
  });

  it('renders correctly when error exists', () => {
    const wrapper = shallow(<InputError error="true" />);
    expect(wrapper.find('.labelError').exists()).toEqual(true);
  });
});
