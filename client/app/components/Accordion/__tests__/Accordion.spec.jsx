// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Accordion } from '../index';

const id = 'some-id';
const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;

describe('Accordion', () => {
  describe('open props is undefined', () => {
    it('toggles correctly', () => {
      const wrapper = shallow(
        <Accordion id={id} title={title}>
          {children}
        </Accordion>,
      );
      expect(wrapper.find('.accordionContent').length).toEqual(0);
      wrapper.find('.accordion').simulate('click');
      expect(wrapper.find('.accordionContent').length).toEqual(1);
      wrapper.find('.accordion').simulate('click');
      expect(wrapper.find('.accordionContent').length).toEqual(0);
    });
  });

  describe('open props is true', () => {
    it('toggles correctly', () => {
      const wrapper = shallow(
        <Accordion id={id} title={title} open>
          {children}
        </Accordion>,
      );
      expect(wrapper.find('.accordionContent').length).toEqual(1);
      wrapper.find('.accordion').simulate('click');
      expect(wrapper.find('.accordionContent').length).toEqual(0);
      wrapper.find('.accordion').simulate('click');
      expect(wrapper.find('.accordionContent').length).toEqual(1);
    });
  });
});
