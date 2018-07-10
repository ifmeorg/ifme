// @flow
import { shallow } from 'enzyme';
import React from 'react';
import Switch from '../Switch';

describe('Switch', () => {
  it('always renders the switch', () => {
    const wrapper = shallow(<Switch />);
    expect(wrapper.find('input').exists()).toEqual(true);
  });
  it('checks if switch toggles on click', () => {
    const wrapper = shallow(<Switch />);
    expect(wrapper.state('checked')).toEqual(false);
    wrapper.find('input').simulate('click');
    expect(wrapper.state('checked')).toEqual(true);
  });
});
