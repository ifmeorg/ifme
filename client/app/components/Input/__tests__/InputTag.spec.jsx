// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';

const { inputTagProps, createInput } = InputMocks;
const getComponent = (extraProps = {}) => createInput(inputTagProps, extraProps);
// baseline for most tests
const component = getComponent();
const { checkboxes } = inputTagProps;

describe('InputTag', () => {
  it('renders input correctly', () => {
    render(component);

    const combobox = screen.getByRole('combobox');
    const input = screen.getByRole('textbox');
    const listbox = screen.getByRole('listbox');

    expect(combobox).toBeInTheDocument();
    expect(input).toBeInTheDocument();
    expect(listbox).toBeInTheDocument();
  });

  it('toggles menu options correctly', () => {
    render(component);
    const input = screen.getByRole('textbox');
    expect(screen.queryByRole('option')).not.toBeInTheDocument();
    // toggle options by focusing on input
    userEvent.click(input);
    expect(screen.getAllByRole('option')).toHaveLength(2);
  });

  it('un-check existing value', () => {
    const [{ label: labelOne }] = checkboxes;
    render(component);

    const queryOptions = { name: labelOne };
    // toggle off the target option's checkbox, so we can test re-selecting it below
    let checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
    userEvent.click(checkbox);
    // after toggling it, the checkbox should disappear
    checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).not.toBeInTheDocument();
  });

  it('type in value and select it', () => {
    const [{ label: labelOne }] = checkboxes;
    render(component);

    const queryOptions = { name: labelOne };
    let checkbox = screen.getByRole('checkbox', queryOptions);
    // un-check selected value so we can re-select it
    userEvent.click(checkbox);
    // at this point the checkbox for the option should not be visible
    expect(checkbox).not.toBeInTheDocument();

    // simulate searching for an option
    const input = screen.getByRole('textbox');
    userEvent.type(input, 'One');
    // after selecting the option, its associated checkbox should exist
    const option = screen.getByRole('option', queryOptions);
    userEvent.click(option);

    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  it('selects a value with keydown without specifying text', () => {
    const [{ label: labelOne }] = checkboxes;
    render(component);

    const input = screen.getByRole('textbox');

    const queryOptions = { name: labelOne };
    let checkbox = screen.getByRole('checkbox', queryOptions);
    // unselect checkbox for the test first
    userEvent.click(checkbox);
    checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).not.toBeInTheDocument();

    userEvent.click(input);
    // expect first item to be highlighted, so it can be selected
    expect(screen.getByRole('option', queryOptions)).toHaveAttribute(
      'aria-selected',
      'true',
    );
    userEvent.type(input, '{enter}');

    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  it('does not select value if no match exists and calls onChange prop if defined', () => {
    const onChange = jest.fn();
    render(getComponent({ onChange }));

    const input = screen.getByRole('textbox');
    // unselect selected checkbox value first
    userEvent.click(screen.getByRole('checkbox'));
    expect(screen.queryByRole('checkbox')).not.toBeInTheDocument();

    userEvent.click(input);
    userEvent.type(input, 'Three');
    expect(screen.queryByRole('option')).not.toBeInTheDocument();

    userEvent.type(input, '{enter}');

    expect(screen.queryByRole('checkbox')).not.toBeInTheDocument();
    expect(onChange).toHaveBeenCalledWith(
      expect.objectContaining({
        label: 'Three',
      }),
    );
  });
});
