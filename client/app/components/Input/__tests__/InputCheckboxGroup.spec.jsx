// @flow
import React from 'react';
import { mount } from 'enzyme';
import { act } from 'react-dom/test-utils';
import { InputCheckboxGroup } from '../InputCheckboxGroup';

const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const idTwo = 'some-other-id';
const nameTwo = 'some-other-name';
const labelTwo = 'Some Other Label';
const someEvent = () => {
  window.alert('Error');
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
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  describe('has no required prop', () => {
    it('does not call hasError prop when all checkboxes are unchecked', () => {
      const wrapper = mount(
        <InputCheckboxGroup checkboxes={checkboxes} hasError={someEvent} />,
      );
      act(() => {
        wrapper
          .find(`input[name="${name}"][type="checkbox"]`)
          .prop('onChange')({ currentTarget: { checked: false } });
      });
      act(() => {
        wrapper.find(`input[name="${nameTwo}"]`).prop('onChange')({
          currentTarget: { checked: false },
        });
      });
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
      act(() => {
        wrapper
          .find(`input[name="${name}"][type="checkbox"]`)
          .prop('onChange')({ currentTarget: { checked: false } });
      });
      act(() => {
        wrapper.find(`input[name="${nameTwo}"]`).prop('onChange')({
          currentTarget: { checked: false },
        });
      });
      expect(window.alert).toHaveBeenCalledWith('Error');
    });
  });
});
