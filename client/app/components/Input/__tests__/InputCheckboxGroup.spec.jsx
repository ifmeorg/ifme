// @flow
import { mount } from 'enzyme';
import React from 'react';
import { InputCheckboxGroup } from '../InputCheckboxGroup';

const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const idTwo = 'some-other-id';
const nameTwo = 'some-other-name';
const labelTwo = 'Some Other Label';
const someEvent = () => {
  window.alert('Event triggered!');
};
const checkboxes = [
  {
    id,
    name,
    label,
    value: 1,
    checked: true,
    uncheckedValue: 0,
  },
  {
    id: idTwo,
    name: nameTwo,
    label: labelTwo,
    value: 2,
  },
];

describe('InputCheckboxGroup', () => {
  beforeAll(() => {
    spyOn(window, 'alert');
  });

  describe('has no required prop', () => {
    it('does not call hasError prop when all checkboxes are unchecked', () => {
      const wrapper = mount(
        <InputCheckboxGroup checkboxes={checkboxes} hasError={someEvent} />,
      );
      expect(
        typeof wrapper.state('checkboxes')[1].checked === 'undefined',
      ).toEqual(true);
      wrapper.find(`input[name="${nameTwo}"]`).simulate('click');
      expect(wrapper.state('checkboxes')[1].checked).toEqual(true);
      expect(wrapper.state('checkboxes')[0].checked).toEqual(true);
      wrapper.find(`input[name="${name}"][type="checkbox"]`).simulate('click');
      expect(wrapper.state('checkboxes')[0].checked).toEqual(false);
      wrapper.find(`input[name="${nameTwo}"]`).simulate('click');
      expect(wrapper.state('checkboxes')[1].checked).toEqual(false);
      expect(window.alert).not.toHaveBeenCalled();
    });
  });

  describe('has required prop', () => {
    it('does calls hasError prop when all checkboxes are unchecked', () => {
      const wrapper = mount(
        <InputCheckboxGroup
          checkboxes={checkboxes}
          hasError={someEvent}
          required
        />,
      );
      expect(
        typeof wrapper.state('checkboxes')[1].checked === 'undefined',
      ).toEqual(true);
      wrapper.find(`input[name="${nameTwo}"]`).simulate('click');
      expect(wrapper.state('checkboxes')[1].checked).toEqual(true);
      expect(wrapper.state('checkboxes')[0].checked).toEqual(true);
      wrapper.find(`input[name="${name}"][type="checkbox"]`).simulate('click');
      expect(wrapper.state('checkboxes')[0].checked).toEqual(false);
      wrapper.find(`input[name="${nameTwo}"]`).simulate('click');
      expect(wrapper.state('checkboxes')[1].checked).toEqual(false);
      expect(window.alert).toHaveBeenCalled();
    });
  });
});
