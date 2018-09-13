// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputSubmit } from '../InputSubmit';

const id = 'some-id';
const name = 'some-name';
const value = 'Some Value';
const someEvent = () => {
  window.alert('Event triggered!');
};

describe('InputSubmit', () => {
  beforeAll(() => {
    spyOn(window, 'alert');
  });

  it('toggles clicking correctly', () => {
    const wrapper = shallow(
      <InputSubmit
        id={id}
        onClick={someEvent}
        value={value}
      />,
    );
    wrapper.find('input').simulate('click');
    expect(window.alert).toHaveBeenCalled();
    wrapper.find('input').simulate('click');
    expect(window.alert).toHaveBeenCalled();
  });
});
