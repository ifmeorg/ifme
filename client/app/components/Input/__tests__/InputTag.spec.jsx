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

    const queryOptions = { name: checkboxLabelTwo };
    let checkbox = screen.queryByRole('checkbox', queryOptions);
    // at this point the checkbox for the option should still not be visible
    expect(checkbox).not.toBeInTheDocument();

    // but after selecting the option, its associated checkbox should exist
    const option = screen.getByRole('option', queryOptions);
    userEvent.click(option);

    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  it('un-check existing value and retype and select it', () => {
    const [{ label: checkboxLabelOne }] = checkboxes;
    render(component);

    const combobox = screen.getByRole('combobox');
    const input = screen.getByRole('textbox');

    expect(combobox).toBeInTheDocument();
    expect(input).toBeInTheDocument();

    const queryOptions = { name: checkboxLabelOne };
    // toggle off the target option's checkbox, so we can test re-selecting it below
    let checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
    userEvent.click(checkbox);
    // after toggling it, the checkbox should disappear
    checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).not.toBeInTheDocument();

    // search for the option and re-select it
    userEvent.type(input, 'One');
    userEvent.click(input);
    checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).not.toBeInTheDocument();
    const option = screen.getByRole('option', queryOptions);
    userEvent.click(option);
    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });
});
