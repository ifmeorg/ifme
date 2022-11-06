// @flow
import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import { Accordion } from 'components/Accordion';

const id = 'some-id';
const title = 'Accordions have pianos';
const children = <strong>Hello</strong>;
const openToggle = (e: SyntheticKeyboardEvent<HTMLDivElement>) => {
  window.alert('Key pressed', e);
};

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

  describe('open when enter key is pressed', () => {
    it('toggles correctly', () => {
      const component = (
        <Accordion id={id} title={title} onKeyDown={openToggle}>
          {children}
        </Accordion>
      );
      const { getByRole } = render(component);

      const accordionContent = getByRole('region');
      const accordionBtn = getByRole('button');
      fireEvent.keyDown(accordionBtn, {
        key: 'Enter',
      });

      expect(accordionContent).toHaveClass('accordionContent');
      fireEvent.click(accordionBtn);
      expect(accordionContent).toHaveClass('accordionClose');
    });
  });
});
