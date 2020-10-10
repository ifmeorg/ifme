// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';
import { InputSelect } from 'components/Input/InputSelect';

const {
  id, name, ariaLabel, value, options,
} = InputMocks.inputSelectProps;
const someEvent = InputMocks.event;

describe('InputSelect', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('renders correctly', () => {
    render(
      <InputSelect
        name={name}
        id={id}
        ariaLabel={ariaLabel}
        value={value}
        options={options}
        onChange={someEvent}
      />,
    );
    const select = screen.getByRole('combobox', { name: ariaLabel });
    expect(select).toBeInTheDocument();
    expect(screen.getAllByRole('option').length).toEqual(2);
    expect(screen.getByRole('presentation')).toBeInTheDocument();
  });

  it('toggles options correctly', () => {
    render(
      <InputSelect
        name={name}
        id={id}
        ariaLabel={ariaLabel}
        value={value}
        options={options}
        onChange={someEvent}
      />,
    );
    // toggle the first value
    const select = screen.getByRole('combobox', { name: ariaLabel });
    userEvent.selectOptions(
      select,
      screen.getByRole('option', { name: options[0].label }),
    );
    expect(window.alert).toHaveBeenCalled();
    expect(select.value).toEqual(`${options[0].value}`);

    // update the value
    userEvent.selectOptions(
      select,
      screen.getByRole('option', { name: options[1].label }),
    );
    expect(window.alert).toHaveBeenCalled();
    expect(select.value).toEqual(`${options[1].value}`);
  });
});
