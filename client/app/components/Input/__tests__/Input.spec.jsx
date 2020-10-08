// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import css from '../Input.scss';

/**
 * TODO: Follow up on an issue when using the matcher `.toBeVisible()` on the inputs directly.
 * The components behave correctly, but the computed styles don't seem to correspond.
 * Even if the accordion is closed, and uses the class 'accordionClose', the actual style returns
 * a visible value for the 'display' property, as opposed to the expected value 'none'.
 * This is also seen with the helper `.toHaveStyle()` (in @testing-library/jest-dom@5.11.4).
 * For now, checking whether div["role='region'"] from Accordion has the class 'accordionClose'.
 */

describe('Input', () => {
  describe('InputDefault', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const { label } = InputMocks.inputTextProps;
        render(
          InputMocks.createInput(InputMocks.inputTextProps, {
            accordion: true,
          }),
        );

        const input = screen.getByRole('textbox');
        const button = screen.getByRole('button', { name: new RegExp(label) });
        const accordionContainer = screen.getByRole('region');

        expect(input).toBeInTheDocument();

        expect(accordionContainer).toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).not.toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).toHaveClass(css.accordionClose);
      });
    });
  });

  describe('CheckboxGroup', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const {
          label: groupLabel,
          checkboxes: [{ label }],
        } = InputMocks.inputCheckboxGroupProps;
        render(
          InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
            accordion: true,
          }),
        );

        const checkbox = screen.getByRole('checkbox', { name: label });
        const button = screen.getByRole('button', { name: groupLabel });
        const accordionContainer = screen.getByRole('region');

        expect(checkbox).toBeInTheDocument();

        expect(accordionContainer).toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).not.toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).toHaveClass(css.accordionClose);
      });
    });
  });

  describe('Select', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const { label } = InputMocks.inputSelectProps;
        render(
          InputMocks.createInput(InputMocks.inputSelectProps, {
            accordion: true,
          }),
        );

        const combobox = screen.getByRole('combobox');
        const button = screen.getByRole('button', { name: label });
        const accordionContainer = screen.getByRole('region');

        expect(combobox).toBeInTheDocument();

        expect(accordionContainer).toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).not.toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).toHaveClass(css.accordionClose);
      });
    });
  });

  describe('Tag', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const { label } = InputMocks.inputTagProps;
        render(
          InputMocks.createInput(InputMocks.inputTagProps, {
            accordion: true,
          }),
        );

        const combobox = screen.getByRole('combobox');
        const button = screen.getByRole('button', { name: new RegExp(label) });
        const accordionContainer = screen.getByRole('region');

        expect(combobox).toBeInTheDocument();

        expect(accordionContainer).toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).not.toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).toHaveClass(css.accordionClose);
      });
    });
  });

  describe('Switch', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const { label } = InputMocks.inputSwitchProps;
        render(
          InputMocks.createInput(InputMocks.inputSwitchProps, {
            accordion: true,
          }),
        );

        const switchInput = screen.getByRole('switch');
        const button = screen.getByRole('button', { name: new RegExp(label) });
        const accordionContainer = screen.getByRole('region');

        expect(switchInput).toBeInTheDocument();

        expect(accordionContainer).toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).not.toHaveClass(css.accordionClose);
        userEvent.click(button);
        expect(accordionContainer).toHaveClass(css.accordionClose);
      });
    });
  });
});
