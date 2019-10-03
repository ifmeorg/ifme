import React from 'react';
import { mount } from 'enzyme';
import { QuickCreate } from '../index';

const checkboxes = [
{ id: 'second', value: 'value', label: 'second_label' },
{ id: 'first', value: 'value', label: 'first_label' }
];

describe('QuickCreate', () => {
  let tree;
  beforeEach(() => {
    tree = mount(<QuickCreate name='name' id='123' label='label' checkboxes={ checkboxes } />);
  });

  afterEach(() => {
    tree && tree.unmount();
  });

  it('sets correct initial values in state', () => {
    const state = tree.state();
    expect(state).toHaveProperty('checkboxes');
    expect(state).toHaveProperty('open', false);
    expect(state).toHaveProperty('accordionOpen', false);
  });

  it('sorts checkboxes prop when setting state', () => {
    const checkboxes = tree.state('checkboxes');
    expect(checkboxes[0].id).toBe('first');
    expect(checkboxes[1].id).toBe('second');
  });
  
  it('renders Input', () => {
    expect(tree.find('Input')).toHaveLength(1);
  });
  
  it('renders Modal', () => {
    expect(tree.find('Modal')).toHaveLength(1);
  });
  // describe('#getCheckboxes', () => {
  //   it('return checkbox array from state');
  // });
  // describe('#onChange', () => {
  //   it('sets state if label does not exist');
  //   it('does not change state if label exists');
  // });
  // describe('#labelExists', () => {
  //   it('return checkbox array from state');
  // });
  // describe('#addToCheckboxes', () => {
  //   it('return checkbox array from state');
  // });
  describe('#onCreate', () => {
    it('calls addToCheckboxes', () => {
      const spy = jest.spyOn(tree.instance(), 'addToCheckboxes');
      tree.instance().onCreate({ data: { success: true }});
      expect(spy).toHaveBeenCalled();
      spy.mockRestore();
    });

    it('sets state and renders Modal/Input with correct key', () => {
      expect(tree.state('accordionOpen')).toBeFalsy();
      tree.instance().onCreate({ data: { success: true }});
      tree.update();
      const modalKey = tree.find('Modal').key();
      const inputKey = tree.find('Input').key();
      expect(tree.state('accordionOpen')).toBeTruthy();
      expect(tree.state('modalKey')).toBe(modalKey);
      expect(tree.state('tagKey')).toBe(inputKey);
    });
  });
});
