import React from 'react';
import { mount } from 'enzyme';
import { QuickCreate } from '../index';

const checkboxes = [
  { id: 'last', value: 'a_value', label: 'zoo_label' },
  { id: 'middle', value: 'middle_value', label: 'middle_label' },
  { id: 'first', value: 'z_value', label: 'alpha_label' },
  { id: 'dm', value: 'duplicate_middle_value', label: 'middle_label' },
];

describe('QuickCreate', () => {
  let wrapper;
  beforeEach(() => {
    wrapper = mount(
      <QuickCreate
        name="name"
        id="123"
        label="label"
        checkboxes={checkboxes}
        formProps={{ inputs: [{}] }}
      />,
    );
  });

  afterEach(() => {
    jest.restoreAllMocks();
    wrapper && wrapper.unmount(); // eslint-disable-line no-unused-expressions
  });

  it('sets correct initial values in state', () => {
    const state = wrapper.state();
    expect(state).toHaveProperty('checkboxes');
    expect(state).toHaveProperty('open', false);
    expect(state).toHaveProperty('accordionOpen', false);
  });

  it('sorts checkboxes by label', () => {
    const checkboxesFromState = wrapper.state('checkboxes');
    expect(checkboxesFromState[0].id).toBe('first');
    expect(checkboxesFromState[3].id).toBe('last');
  });

  it('renders Modal initially closed', () => {
    const modal = wrapper.find('Modal');
    expect(modal).toHaveLength(1);
    expect(modal.prop('open')).toBeFalsy();
  });

  describe('when input is changed', () => {
    it('opens modal and displays quick create form if label does not exist', () => {
      expect(wrapper.find('DynamicForm')).toHaveLength(0);
      expect(wrapper.find('Modal').prop('open')).toBeFalsy();
      wrapper.find('Input').prop('onChange')({
        checkboxes,
        label: 'new_label',
      });
      wrapper.update();
      expect(wrapper.find('Modal').prop('open')).toBeTruthy();
      expect(wrapper.find('DynamicForm')).toHaveLength(1);
    });

    it('does nothing if label exists', () => {
      expect(wrapper.find('DynamicForm')).toHaveLength(0);
      expect(wrapper.find('Modal').prop('open')).toBeFalsy();
      wrapper.find('Input').prop('onChange')({
        checkboxes,
        label: 'alpha_label',
      });
      wrapper.update();
      expect(wrapper.find('Modal').prop('open')).toBeFalsy();
      expect(wrapper.find('DynamicForm')).toHaveLength(0);
    });
  });

  describe('when dynamic form is submit', () => {
    beforeEach(() => {
      // render DynamicForm
      wrapper.find('Input').prop('onChange')({
        checkboxes,
        label: 'new_label',
      });
      wrapper.update();
    });

    it('adds checkboxes from data', () => {
      const spy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(4);
      wrapper.find('DynamicForm').prop('onCreate')({
        data: {
          success: true,
          name: 'third_label',
          id: 'third_value',
          slug: 'third',
        },
      });
      wrapper.update();
      expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(5);
      expect(spy).toHaveBeenCalledTimes(1);
    });

    it('opens accordion and closes modal; renders Modal/Input with correct key', () => {
      let input = wrapper.find('Input');
      let modal = wrapper.find('Modal');
      expect(input.prop('accordionOpen')).toBeFalsy();
      expect(modal.prop('open')).toBeTruthy();
      wrapper.find('DynamicForm').prop('onCreate')({
        data: {
          success: true,
          name: 'third_label',
          id: 'third_value',
          slug: 'third',
        },
      });
      wrapper.update();
      input = wrapper.find('Input');
      modal = wrapper.find('Modal');
      expect(modal.prop('open')).toBeFalsy();
      expect(input.prop('accordionOpen')).toBeTruthy();
      expect(modal.key()).toBe(wrapper.state('modalKey'));
      expect(input.key()).toBe(wrapper.state('tagKey'));
    });

    it('does not do anything if response data is not a success', () => {
      const spy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      let input = wrapper.find('Input');
      let modal = wrapper.find('Modal');
      expect(input.prop('accordionOpen')).toBeFalsy();
      expect(modal.prop('open')).toBeTruthy();
      wrapper.find('DynamicForm').prop('onCreate')({
        data: { success: false },
      });
      wrapper.update();
      input = wrapper.find('Input');
      modal = wrapper.find('Modal');
      expect(modal.prop('open')).toBeTruthy();
      expect(input.prop('accordionOpen')).toBeFalsy();
      expect(spy).toHaveBeenCalledTimes(0);
    });
  });
});
