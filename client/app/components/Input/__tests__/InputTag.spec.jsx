// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputTagProps);
const { checkboxes } = InputMocks.inputTagProps;

describe('InputTag', () => {
  it('type in value and select it', () => {
    const [, { label: checkboxLabelTwo }] = checkboxes;
    render(component);

    const combobox = screen.getByRole('combobox');
    const input = screen.getByRole('textbox');

    expect(combobox).toBeInTheDocument();
    expect(input).toBeInTheDocument();

    // simulate searching for an option
    userEvent.type(input, 'Two');
    userEvent.click(input);

    // at this point the checkbox for the option should still not be visible
    expect(
      screen.queryByRole('checkbox', { name: checkboxLabelTwo }),
    ).not.toBeInTheDocument();
    // but after selecting the option, its associated checkbox should exist
    userEvent.click(screen.getByRole('option', { name: checkboxLabelTwo }));
    expect(
      screen.getByRole('checkbox', { name: checkboxLabelTwo }),
    ).toBeInTheDocument();
  });

  it('un-check existing value and retype and select it', () => {
    const [{ label: checkboxLabelOne }] = checkboxes;
    render(component);

    const combobox = screen.getByRole('combobox');
    const input = screen.getByRole('textbox');

    expect(combobox).toBeInTheDocument();
    expect(input).toBeInTheDocument();

    // toggle off the target option's checkbox, so we can test re-selecting it below
    const checkbox = screen.getByRole('checkbox', { name: checkboxLabelOne });
    expect(checkbox).toBeInTheDocument();
    userEvent.click(checkbox);
    // after toggling it, the checkbox should disappear
    expect(
      screen.queryByRole('checkbox', { name: checkboxLabelOne }),
    ).not.toBeInTheDocument();

    // search for the option and re-select it
    userEvent.type(input, 'One');
    userEvent.click(input);
    expect(
      screen.queryByRole('checkbox', { name: checkboxLabelOne }),
    ).not.toBeInTheDocument();
    userEvent.click(screen.getByRole('option', { name: checkboxLabelOne }));
    expect(
      screen.getByRole('checkbox', { name: checkboxLabelOne }),
    ).toBeInTheDocument();
  });
});
