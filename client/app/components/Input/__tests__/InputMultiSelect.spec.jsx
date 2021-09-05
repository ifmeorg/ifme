// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import { InputMultiSelect } from 'components/Input/InputMultiSelect';

const {
  id, name, ariaLabel, value, options,
} = InputMocks.inputSelectProps;
const someEvent = InputMocks.event;

describe('InputMultiSelect', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('renders correctly', () => {
    render(
      <InputMultiSelect
        name={name}
        id={id}
        ariaLabel={ariaLabel}
        value={value}
        options={options}
        onChange={someEvent}
      />,
    );
    const multiSelect = screen.getByRole('button', { className: 'buttonL' });
    expect(multiSelect).toBeInTheDocument();
    expect(screen.getAllByRole('checkbox').length).toEqual(2);
  });

  it('toggles options correctly', () => {
    render(
      <InputMultiSelect
        name={name}
        id={id}
        ariaLabel={ariaLabel}
        options={options}
        onChange={someEvent}
      />,
    );
    // toggle the first value
    const multiSelect = screen.getByRole('componentValue', { hidden: true });
    const checkbox = screen.getByRole('checkbox', { name: options[0].label });
    const checkbox2 = screen.getByRole('checkbox', { name: options[1].label });

    userEvent.click(checkbox);
    expect(multiSelect.value).toEqual(`${options[0].value}`);

    // update the value
    userEvent.click(checkbox2);
    expect(multiSelect.value).toEqual(`${options[0].value},${options[1].value}`);

    // update the value by unchecking
    userEvent.click(checkbox);
    expect(multiSelect.value).toEqual(`${options[1].value}`);

  });
});
