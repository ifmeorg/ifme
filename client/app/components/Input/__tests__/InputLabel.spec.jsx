// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputLabel } from '../InputLabel';

const label = 'Some Label';
const info = 'Some Info';

describe('InputLabel', () => {
  it('renders correctly', () => {
    const wrapper = shallow(
      <InputLabel label={label} required info={info} error />,
    );
    expect(wrapper.find('.labelText').exists()).toEqual(true);
  });
});
