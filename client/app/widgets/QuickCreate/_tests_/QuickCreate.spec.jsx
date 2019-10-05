import React from 'react';
import { mount } from 'enzyme';
import { QuickCreate } from '../index';

const checkboxes = [
{ id: 'second', value: 'second_value', label: 'second_label' },
{ id: 'first', value: 'first_value', label: 'first_label' }
];

const formProps = {
  inputs: [ {} ]
};

describe('QuickCreate', () => {
  let wrapper;
  beforeEach(() => {
    wrapper = mount(<QuickCreate 
      name='name' 
      id='123' 
      label='label' 
      checkboxes={ checkboxes } 
      formProps={ formProps } />
    );
  });

  afterEach(() => {
    jest.restoreAllMocks();
    wrapper && wrapper.unmount();
  });

  it('sets correct initial values in state', () => {
    const state = wrapper.state();
    expect(state).toHaveProperty('checkboxes');
    expect(state).toHaveProperty('open', false);
    expect(state).toHaveProperty('accordionOpen', false);
  });

  it('sorts checkboxes', () => {
    const checkboxes = wrapper.state('checkboxes');
    expect(checkboxes[0].id).toBe('first');
    expect(checkboxes[1].id).toBe('second');
  });
  
  it('renders Input', () => {
    expect(wrapper.find('Input')).toHaveLength(1);
  });
  
  it('renders Modal', () => {
    expect(wrapper.find('Modal')).toHaveLength(1);
  });
  // describe('#getCheckboxes', () => {
  //   it('return checkbox array from state');
  // });
  // 
  describe('#onChange', () => {
    it('opens modal and displays quick create form if label does not exist', function () {
      expect(wrapper.find('DynamicForm')).toHaveLength(0);
      expect(wrapper.find('Modal').prop('open')).toBeFalsy();
      wrapper.find('Input').prop('onChange')({ checkboxes, label: 'new_label' });
      wrapper.update();
      expect(wrapper.find('Modal').prop('open')).toBeTruthy();
      expect(wrapper.find('DynamicForm')).toHaveLength(1);
    });

    // it('does nothing if label exists');
  });

  // describe('#labelExists', () => {
  //   it('return checkbox array from state');
  // });
  // describe('#addToCheckboxes', () => {
  //   it('return checkbox array from state');
  // });
  describe('#onCreate', () => {
    beforeEach(() => {
      // render DynamicForm
      wrapper.find('Input').prop('onChange')({ checkboxes, label: 'new_label' });
      wrapper.update();
    });

    it('adds checkboxes from data', () => {
      const addCheckboxesSpy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(2);
      wrapper.find('DynamicForm').prop('onCreate')({ data: { 
        success: true,
        name: 'third_label',
        id: 'third_value',
        slug: 'third'
      }});
      wrapper.update();
      expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(3);
      expect(addCheckboxesSpy).toHaveBeenCalled();
    });

    it('opens accordion and renders Modal/Input with correct key', () => {
      expect(wrapper.state('accordionOpen')).toBeFalsy();
      wrapper.find('DynamicForm').prop('onCreate')({ data: { 
        success: true,
        name: 'third_label',
        id: 'third_value',
        slug: 'third'
      }});
      wrapper.update();
      const input = wrapper.find('Input');
      const modalKey = wrapper.find('Modal').key();
      expect(wrapper.state('accordionOpen')).toBeTruthy();
      expect(input.prop('accordionOpen')).toBeTruthy();
      expect(modalKey).toBe(wrapper.state('modalKey'));
      expect(input.key()).toBe(wrapper.state('tagKey'));
    });
  });
});
