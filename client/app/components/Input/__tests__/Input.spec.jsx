// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Input } from '../index';

const id = 'some-id';
const name = 'some-name';
const label = 'Some Label';
const idTwo = 'some-other-id';
const nameTwo = 'some-other-name';
const labelTwo = 'Some Other Label';
const options = [{ value: 1, label: 'First' }, { value: 2, label: 'Second' }];
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

describe('Input', () => {
  describe('InputDefault', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          <Input id={id} type="text" name={name} label={label} accordion />,
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
      });
    });
  });

  describe('CheckboxGroup', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          <Input
            id={id}
            type="checkboxGroup"
            name={name}
            label={label}
            checkboxes={checkboxes}
            accordion
          />,
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
      });
    });
  });

  describe('Select', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          <Input
            id={id}
            type="select"
            name={name}
            label={label}
            options={options}
            accordion
          />,
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('select')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('select')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('select')
            .exists(),
        ).toEqual(false);
      });
    });
  });
});
