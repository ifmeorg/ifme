// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { InputMocks } from 'mocks/InputMocks';

const { inputTagProps, createInput } = InputMocks;
const getComponent = (extraProps = {}) => createInput(inputTagProps, extraProps);
// baseline for most tests
const component = getComponent();
const { checkboxes } = inputTagProps;

function setup(jsx) {
  return {
    user: userEvent.setup(),
    ...render(jsx),
  };
}

describe('InputTag', () => {
  it('renders input correctly', () => {
    render(component);

    const combobox = screen.getByRole('combobox');
    const listbox = screen.getByRole('listbox');

    expect(combobox).toBeInTheDocument();
    expect(listbox).toBeInTheDocument();
  });

  it('toggles menu options correctly', async () => {
    const { user } = setup(component);
    const input = screen.getByRole('combobox');
    expect(screen.queryByRole('option')).not.toBeInTheDocument();
    // toggle options by focusing on input
    await user.click(input);
    expect(screen.getAllByRole('option')).toHaveLength(2);
  });

  it('un-check existing value', async () => {
    const [{ label: labelOne }] = checkboxes;
    const { user } = setup(component);

    const queryOptions = { name: labelOne };
    // toggle off the target option's checkbox, so we can test re-selecting it below
    let checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
    await user.click(checkbox);
    // after toggling it, the checkbox should disappear
    checkbox = screen.queryByRole('checkbox', queryOptions);
    expect(checkbox).not.toBeInTheDocument();
  });

  it('type in value and select it', async () => {
    const [{ label: labelOne }] = checkboxes;
    const { user } = setup(component);

    const queryOptions = { name: labelOne };
    let checkbox = screen.getByRole('checkbox', queryOptions);
    // un-check selected value so we can re-select it
    await user.click(checkbox);
    // at this point the checkbox for the option should not be visible
    expect(checkbox).not.toBeInTheDocument();

    // simulate searching for an option
    const input = screen.getByRole('combobox');
    await user.type(input, 'One');
    // after selecting the option, its associated checkbox should exist
    const option = screen.getByRole('option', queryOptions);
    await user.click(option);

    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  it('selects a value with keydown without specifying text', async () => {
    const [{ label: labelOne }] = checkboxes;
    const { user } = setup(component);

    const input = screen.getByRole('combobox');

    const queryOptions = { name: labelOne };
    const checkbox = screen.getByRole('checkbox', queryOptions);
    // unselect checkbox for the test first
    await user.click(checkbox);
    expect(
      screen.queryByRole('checkbox', queryOptions),
    ).not.toBeInTheDocument();

    // focus the input so the menu opens and highlights the first item
    await user.tab();
    expect(input).toHaveFocus();
    // expect first item to be highlighted, so it can be selected
    expect(screen.getByRole('option', queryOptions)).toHaveAttribute(
      'aria-selected',
      'true',
    );

    await user.keyboard('{Enter}');
    expect(screen.getByRole('checkbox', queryOptions)).toBeInTheDocument();
  });

  it('does not select value if no match exists and calls onChange prop if defined', async () => {
    const onChange = jest.fn();
    const { user } = setup(getComponent({ onChange }));

    const input = screen.getByRole('combobox');
    // unselect selected checkbox value first
    await user.click(screen.getByRole('checkbox'));
    expect(screen.queryByRole('checkbox')).not.toBeInTheDocument();

    await user.click(input);
    await user.type(input, 'Three');
    expect(screen.queryByRole('option')).not.toBeInTheDocument();

    await user.type(input, '{enter}');

    expect(screen.queryByRole('checkbox')).not.toBeInTheDocument();
    expect(onChange).toHaveBeenCalledWith(
      expect.objectContaining({
        label: 'Three',
      }),
    );
  });
});
