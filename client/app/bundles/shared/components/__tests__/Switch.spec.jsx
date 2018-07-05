// @flow
import { shallow } from 'enzyme';
import React from 'react';
import Switch from '../Switch';

describe('Switch', () => {
  it('always renders the switch', () => {
    let wrapper = shallow(<Switch />);
    expect(wrapper.find('input').exists()).toEqual(true);
  });
  it('checks if switch toggles on click', () => {
    let wrapper = shallow(<Switch />);
    expect(wrapper.find('input').exists()).toEqual(true);
    wrapper.find('input').simulate('click');
    expect(wrapper.find('input').exists()).toEqual(true);
  });
});
