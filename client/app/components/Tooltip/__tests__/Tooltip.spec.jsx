// @flow
import { render } from 'enzyme';
import React from 'react';
import { Tooltip } from '../index';

describe('Tooltip', () => {
  describe('element is text', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(<Tooltip element="Hello" text="Some text" />);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });

  describe('element is HTML', () => {
    it('renders correctly', () => {
      let wrapper = null;
      expect(() => {
        wrapper = render(<Tooltip element="Hello" text={<div>Some text</div>} />);
      }).not.toThrow();
      expect(wrapper).not.toBeNull();
    });
  });
});
