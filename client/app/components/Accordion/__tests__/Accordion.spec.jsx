// @flow
import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import { Accordion } from '../index';

const id = 'some-id';
const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;

describe('Accordion', () => {
  describe('open props is undefined', () => {
    it('toggles correctly', () => {
      const { getByRole } = render(
        <Accordion id={id} title={title}>
          {children}
        </Accordion>,
      );

      const accordionContent = getByRole('region');
      const accordionBtn = getByRole('button');

      expect(accordionContent).toHaveClass('accordionClose');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionContent');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionClose');
    });
  });

  describe('open props is true', () => {
    it('toggles correctly', () => {
      const { getByRole } = render(
        <Accordion id={id} title={title} open>
          {children}
        </Accordion>,
      );

      const accordionContent = getByRole('region');
      const accordionBtn = getByRole('button');

      expect(accordionContent).toHaveClass('accordionContent');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionClose');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionContent');
    });
  });
});
