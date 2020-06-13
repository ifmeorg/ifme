// @flow
import React from 'react';
import { Accordion } from '../index';
import { render, screen, fireEvent } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';

const id = 'some-id';
const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;

describe('Accordion', () => {
  describe('open props is undefined', () => {
    it('toggles correctly', () => {
      const { getByRole } = render(
        <Accordion id={id} title={title}>
          {children}
        </Accordion>
      );

      const accordionContent = getByRole('list');
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
        </Accordion>
      );

      const accordionContent = getByRole('list');
      const accordionBtn = getByRole('button');

      expect(accordionContent).toHaveClass('accordionContent');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionClose');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionContent');
    });
  });
});
