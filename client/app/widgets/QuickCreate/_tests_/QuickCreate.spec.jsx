import React from 'react';
import { mount } from 'enzyme';
import { QuickCreate } from '../index';

const checkboxes = [
{ id: 'second', value: 'value', label: 'second_label' },
{ id: 'first', value: 'value', label: 'first_label' }
];

describe.only('QuickCreate', () => {
  let tree;
  beforeEach(() => {
    tree = mount(<QuickCreate name='name' id='123' label='label' checkboxes={ checkboxes } />);
  });

  afterEach(() => {
    tree.unmount && tree.unmount();
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
  //it('renders modal as closed initially');
  // describe('#getCheckboxes', () => {
  //   it('return checkbox array from state');
  // });
  // describe('#onChange', () => {
  //   it('sets state if label does not exist');
  //   it('does not change state if label exists');
  // });
});
