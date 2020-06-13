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
    wrapper.unmount();
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
    expect(modal.prop('open')).toBe(false);
  });

  describe('when input is changed', () => {
    function changeInput(label) {
      expect(wrapper.find('DynamicForm')).toHaveLength(0);
      expect(wrapper.find('Modal').prop('open')).toBe(false);
      wrapper.find('Input').prop('onChange')({
        checkboxes,
        label,
      });
      wrapper.update();
    }

    it('opens modal and displays quick create form if label does not exist', () => {
      changeInput('new_label');
      expect(wrapper.find('Modal').prop('open')).toBe(true);
      expect(wrapper.find('DynamicForm')).toHaveLength(1);
    });

    it('does not open the modal if the label already exists', () => {
      changeInput('alpha_label');
      expect(wrapper.find('Modal').prop('open')).toBe(false);
      expect(wrapper.find('DynamicForm')).toHaveLength(0);
    });
  });

  describe('when the form is submitted', () => {
    function submitForm(data) {
      wrapper.find('DynamicForm').prop('onSubmit')({
        data: data || {
          success: true,
          name: 'new_label',
          id: 'new_value',
          slug: 'new_id',
        },
      });
      wrapper.update();
    }

    beforeEach(() => {
      // make the DynamicForm render
      wrapper.find('Input').prop('onChange')({
        checkboxes,
        label: 'new_label',
      });
      wrapper.update();
    });

    it('adds checkboxes from data', () => {
      const spy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(4);
      submitForm();
      expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(5);
      expect(spy).toHaveBeenCalledTimes(1);
    });

    it('opens the accordion, closes the modal, and assigns the correct key to the modal and input field', () => {
      let input = wrapper.find('Input');
      let modal = wrapper.find('Modal');
      expect(input.prop('accordionOpen')).toBe(false);
      expect(modal.prop('open')).toBe(true);
      submitForm();
      input = wrapper.find('Input');
      modal = wrapper.find('Modal');
      expect(modal.prop('open')).toBe(false);
      expect(input.prop('accordionOpen')).toBe(true);
      expect(modal.key()).toBe(wrapper.state('modalKey'));
    });

    it('does not submit the form when response data is invalid', () => {
      const spy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      let input = wrapper.find('Input');
      let modal = wrapper.find('Modal');
      expect(input.prop('accordionOpen')).toBe(false);
      expect(modal.prop('open')).toBe(true);
      submitForm({ success: false });
      input = wrapper.find('Input');
      modal = wrapper.find('Modal');
      expect(modal.prop('open')).toBe(true);
      expect(input.prop('accordionOpen')).toBe(false);
      expect(spy).toHaveBeenCalledTimes(0);
    });
  });
});
