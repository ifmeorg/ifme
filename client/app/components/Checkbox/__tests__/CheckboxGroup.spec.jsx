// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Checkbox } from '../index';
import { CheckboxGroup } from '../CheckboxGroup';

function handleCheckboxClick(allChecked) {
  window.alert(`Here's an example of an action: ${allChecked}`);
}

function messaging(ids) {
  return `Here's an example of an action: ${ids}`;
}

describe('CheckboxGroup', () => {
  beforeAll(() => {
    spyOn(window, 'alert');
  });

  describe('when there is one checkbox', () => {
    const checkboxGroup = (
      <CheckboxGroup action={allChecked => handleCheckboxClick(allChecked)}>
        <Checkbox label="Option 1" id="checkbox-one" />
      </CheckboxGroup>
    );

    it('toggles correctly', () => {
      const wrapper = mount(checkboxGroup);
      const checkbox = wrapper.find('#checkbox-one .checkbox');
      checkbox.simulate('click');
      wrapper.update();
      expect(window.alert).toHaveBeenCalledWith(messaging('checkbox-one'));
      checkbox.simulate('click');
      wrapper.update();
      expect(window.alert).toHaveBeenCalledWith(messaging(''));
    });
  });

  describe('when there are multiple checkboxes', () => {
    const checkboxGroup = (
      <CheckboxGroup action={allChecked => handleCheckboxClick(allChecked)}>
        <Checkbox label="Option 1" id="checkbox-one" />
        <Checkbox label="Option 2" id="checkbox-two" checked />
      </CheckboxGroup>
    );

    it('toggles correctly', () => {
      const wrapper = mount(checkboxGroup);
      const checkboxOne = wrapper.find('#checkbox-one .checkbox');
      const checkboxTwo = wrapper.find('#checkbox-two .checkbox');
      checkboxOne.simulate('click');
      wrapper.update();
      expect(window.alert).toHaveBeenCalledWith(
        messaging('checkbox-two,checkbox-one'),
      );
      checkboxOne.simulate('click');
      wrapper.update();
      expect(window.alert).toHaveBeenCalledWith(messaging('checkbox-two'));
      checkboxTwo.simulate('click');
      wrapper.update();
      expect(window.alert).toHaveBeenCalledWith(messaging(''));
    });
  });
});
