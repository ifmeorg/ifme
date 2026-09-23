// @flow
import React from 'react';
import {
  render, screen, fireEvent, act,
} from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import Form from 'components/Form';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const STORAGE_KEY = 'ifme_autosave_fake-action';

const renderMinimalForm = () => render(
  <Form
    action="/fake-action"
    inputs={[
      InputMocks.inputTextProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputSubmitProps,
    ]}
  />,
);

const renderFullForm = () => render(
  <Form
    action="/fake-action"
    inputs={[
      InputMocks.inputTextProps,
      InputMocks.inputSelectProps,
      InputMocks.inputRadioProps,
      InputMocks.inputCheckboxProps,
      InputMocks.inputCheckboxGroupProps,
      InputMocks.inputMultiSelectProps,
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputNumberProps,
      InputMocks.inputSubmitProps,
    ]}
  />,
);

const getComponent = () => (
  <Form
    action="/fake-action"
    inputs={[
      { ...InputMocks.inputTextProps, required: true },
      InputMocks.inputSelectProps,
      { ...InputMocks.inputCheckboxGroupProps, required: true },
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputNumberProps,
      InputMocks.inputSubmitProps,
    ]}
  />
);

describe('Form', () => {
  const {
    getByRole,
    queryByRole,
    getByPlaceholderText,
    getByLabelText,
    getByText,
  } = screen;

  it('renders correctly', () => {
    render(getComponent());
    expect(getByPlaceholderText('Some Text Placeholder')).toBeInTheDocument();
    expect(
      getByRole('button', { name: 'Some Submit Value' }),
    ).toBeInTheDocument();
  });

  describe('for changes on the input with text type', () => {
    it('has no errors when submit is clicked', async () => {
      render(getComponent());
      await userEvent.type(
        getByPlaceholderText('Some Text Placeholder'),
        'randomName',
      );
      await userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      expect(queryByRole('alert')).not.toBeInTheDocument();
    });

    it('has errors when submit is clicked', async () => {
      const { container } = render(getComponent());
      const form = container.querySelector('form');
      const scrollIntoViewMock = jest.fn();
      window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
      // Using fireEvent.submit instead of userEvent.click because jsdom does not fully
      // implement HTMLFormElement.prototype.requestSubmit (used internally by user-event
      // when clicking a submit button). This should be revisited when jsdom adds support,
      // likely after the React 18 upgrade
      await fireEvent.submit(form);
      expect(getByText('This field cannot be empty!')).toBeInTheDocument();
    });
  });

  describe('auto-save', () => {
    beforeEach(() => { localStorage.clear(); });
    afterEach(() => { localStorage.clear(); });

    describe('interval', () => {
      beforeEach(() => { jest.useFakeTimers(); });
      afterEach(() => { jest.useRealTimers(); });

      it('does not write to localStorage when nothing has changed from the initial form state', () => {
        renderMinimalForm();
        act(() => { jest.advanceTimersByTime(2000); });
        expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
      });

      it('does not write to localStorage when only default/pre-filled values are present', () => {
        render(
          <Form
            action="/fake-action"
            inputs={[
              InputMocks.inputSelectProps,
              { ...InputMocks.inputCheckboxProps, checked: true },
              InputMocks.inputSwitchProps,
              InputMocks.inputSubmitProps,
            ]}
          />,
        );
        act(() => { jest.advanceTimersByTime(2000); });
        expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
      });

      it('saves to localStorage after the user changes a text field', () => {
        const { container } = renderMinimalForm();
        fireEvent.change(
          container.querySelector('input[name="some-text-name"]'),
          { target: { value: 'Hello world' } },
        );
        act(() => { jest.advanceTimersByTime(2000); });
        const saved = JSON.parse(localStorage.getItem(STORAGE_KEY));
        expect(saved?.values?.['some-text-name']).toBe('Hello world');
      });

      it('saves to localStorage after the user changes a select', () => {
        const { container } = render(
          <Form
            action="/fake-action"
            inputs={[
              InputMocks.inputSelectProps,
              InputMocks.inputSubmitProps,
            ]}
          />,
        );
        fireEvent.change(
          container.querySelector('select[name="some-select-name"]'),
          { target: { value: '1' } },
        );
        act(() => { jest.advanceTimersByTime(2000); });
        const saved = JSON.parse(localStorage.getItem(STORAGE_KEY));
        expect(saved?.values?.['some-select-name']).toBe('1');
      });

      it('does not re-save to localStorage after the form is submitted', () => {
        const { container } = renderMinimalForm();
        fireEvent.change(
          container.querySelector('input[name="some-text-name"]'),
          { target: { value: 'Hello world' } },
        );
        fireEvent.submit(container.querySelector('form'));
        expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
        act(() => { jest.advanceTimersByTime(2000); });
        expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
      });
    });

    describe('restore banner', () => {
      it('shows when localStorage contains a draft', () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-text-name': 'Saved text' } }),
        );
        renderMinimalForm();
        expect(screen.getByRole('status')).toBeInTheDocument();
        expect(screen.getByRole('button', { name: 'Restore draft' })).toBeInTheDocument();
      });

      it('does not show when localStorage is empty', () => {
        renderMinimalForm();
        expect(screen.queryByRole('status')).not.toBeInTheDocument();
      });

      it('populates text fields with saved values when Restore draft is clicked', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-text-name': 'My restored text' } }),
        );
        renderMinimalForm();
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        expect(screen.getByPlaceholderText('Some Text Placeholder')).toHaveValue('My restored text');
      });

      it('hides the banner and removes the draft when Dismiss is clicked', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-text-name': 'Saved text' } }),
        );
        renderMinimalForm();
        await userEvent.click(screen.getByRole('button', { name: 'Dismiss' }));
        expect(screen.queryByRole('status')).not.toBeInTheDocument();
        expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
      });

      it('removes the draft from localStorage when the form is submitted without errors', () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-text-name': 'Old draft' } }),
        );
        const { container } = renderMinimalForm();
        fireEvent.submit(container.querySelector('form'));
        expect(localStorage.getItem(STORAGE_KEY)).toBeNull();
      });
    });

    describe('restore: all input types', () => {
      it('restores a select to its saved option', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-select-name': '1' } }),
        );
        const { container } = renderFullForm();
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        expect(container.querySelector('select[name="some-select-name"]').value).toBe('1');
      });

      it('restores a radio group to its saved selection', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-radio-name': '2' } }),
        );
        const { container } = renderFullForm();
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        const checkedRadio = container.querySelector('input[type="radio"][name="some-radio-name"]:checked');
        expect(checkedRadio).not.toBeNull();
        expect(checkedRadio.value).toBe('2');
      });

      it('restores a single checkbox to its saved checked state', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-checkbox-name': '1' } }),
        );
        const { container } = renderFullForm();
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        expect(container.querySelector('input[type="checkbox"][name="some-checkbox-name"]').checked).toBe(true);
      });

      it('restores a checkbox group to its saved checked states', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({
            timestamp: Date.now(),
            values: {
              'some-checkbox-one-name': '1',
              'some-checkbox-two-name': '0',
            },
          }),
        );
        const { container } = renderFullForm();
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        expect(container.querySelector('input[type="checkbox"][name="some-checkbox-one-name"]').checked).toBe(true);
        expect(container.querySelector('input[type="checkbox"][name="some-checkbox-two-name"]').checked).toBe(false);
      });

      it('restores a switch toggle to its saved on state', async () => {
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-switch-name': 'true' } }),
        );
        const { container } = renderFullForm();
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        expect(container.querySelector('input[type="checkbox"][name="some-switch-name"]').checked).toBe(true);
      });

      it('restores a quickCreate widget to its saved selections', async () => {
        const quickCreateInput = {
          id: 'some-qc-id',
          type: 'quickCreate',
          name: 'some-qc-name[]',
          label: 'Some QC Label',
          placeholder: 'Search',
          checkboxes: [
            {
              id: 'qc-one', label: 'Option One', value: 1, checked: false,
            },
            {
              id: 'qc-two', label: 'Option Two', value: 2, checked: false,
            },
          ],
          formProps: { action: '/test', inputs: [] },
        };
        localStorage.setItem(
          STORAGE_KEY,
          JSON.stringify({ timestamp: Date.now(), values: { 'some-qc-name[]': ['1'] } }),
        );
        const { container } = render(
          <Form
            action="/fake-action"
            inputs={[quickCreateInput, InputMocks.inputSubmitProps]}
          />,
        );
        await userEvent.click(screen.getByRole('button', { name: 'Restore draft' }));
        const checkbox = container.querySelector(
          'input[type="checkbox"][name="some-qc-name[]"][value="1"]',
        );
        expect(checkbox).not.toBeNull();
        expect(checkbox.checked).toBe(true);
      });
    });
  });

  describe('for changes on the input with number type', () => {
    it('has no errors when submit is clicked', async () => {
      render(getComponent());
      await userEvent.type(
        getByPlaceholderText('Some Text Placeholder'),
        'randomName',
      );
      await userEvent.type(getByLabelText('Some Number Label'), '2');
      await userEvent.click(getByRole('button', { name: 'Some Submit Value' }));
      expect(queryByRole('alert')).not.toBeInTheDocument();
    });

    it('has errors when submit is clicked', async () => {
      const { container } = render(getComponent());
      const form = container.querySelector('form');
      const scrollIntoViewMock = jest.fn();
      window.HTMLElement.prototype.scrollIntoView = scrollIntoViewMock;
      await userEvent.type(
        getByPlaceholderText('Some Text Placeholder'),
        'randomName',
      );
      await userEvent.type(getByLabelText('Some Number Label'), '-1');
      // Using fireEvent.submit instead of userEvent.click because jsdom does not fully
      // implement HTMLFormElement.prototype.requestSubmit (used internally by user-event
      // when clicking a submit button). This should be revisited when jsdom adds support,
      // likely after the React 18 upgrade
      await fireEvent.submit(form);
      expect(
        getByText(
          'This field must be equal or greater than 0 and equal or less than 2!',
        ),
      ).toBeInTheDocument();
    });
  });
});
