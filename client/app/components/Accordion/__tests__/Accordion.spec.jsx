// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Accordion } from '../index';

const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;

describe('Accordion', () => {
  describe('has default props', () => {
    it('toggles correctly', () => {
      const wrapper = shallow(<Accordion title={title}>{children}</Accordion>);
      expect(wrapper.find('.accordionContent').length).toEqual(0);
      wrapper.find('.accordion').simulate('click');
      expect(wrapper.find('.accordionContent').length).toEqual(1);
      wrapper.find('.accordion').simulate('click');
      expect(wrapper.find('.accordionContent').length).toEqual(0);
    });
  });

  describe('has style props', () => {
    it('toggles correctly', () => {
      const wrapper = shallow(
        <Accordion title={title} dark large>
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
});
