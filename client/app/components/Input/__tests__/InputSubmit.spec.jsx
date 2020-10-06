// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import React from 'react';
import { InputMocks } from 'mocks/InputMocks';
import { InputSubmit } from 'components/Input/InputSubmit';

const { id } = InputMocks.inputSubmitProps;
const { value } = InputMocks.inputSubmitProps;
const someEvent = InputMocks.event;

describe('InputSubmit', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('toggles clicking correctly', () => {
    render(<InputSubmit id={id} onClick={someEvent} value={value} />);
    const button = screen.getByRole('button', { name: value });
    userEvent.click(button);
    expect(window.alert).toHaveBeenCalled();
    userEvent.click(button);
    expect(window.alert).toHaveBeenCalled();
  });

  it('does not toggle if disabled', () => {
    render(<InputSubmit id={id} onClick={someEvent} value={value} disabled />);
    const button = screen.getByRole('button', { name: value });
    userEvent.click(button);
    expect(window.alert).not.toHaveBeenCalled();
  });
});
