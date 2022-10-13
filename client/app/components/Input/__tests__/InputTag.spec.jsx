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
    const input = screen.getByRole('textbox');
    const listbox = screen.getByRole('listbox');

    expect(combobox).toBeInTheDocument();
    expect(input).toBeInTheDocument();
    expect(listbox).toBeInTheDocument();
  });

  it('toggles menu options correctly', async () => {
    const { user } = setup(component);
    const input = screen.getByRole('textbox');
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
    const input = screen.getByRole('textbox');
    await user.type(input, 'One');
    // after selecting the option, its associated checkbox should exist
    const option = screen.getByRole('option', queryOptions);
    await user.click(option);

    checkbox = screen.getByRole('checkbox', queryOptions);
    expect(checkbox).toBeInTheDocument();
  });

  /**
   * Skipping this one for now. react-autosuggest still checks for event.keyCode, which
   * is long since deprecated. testing-library/user-event stopped supporting as of v14
   * and now overwrites keyCode to `0` (only to support React's SyntheticEvents which expect
   * a value for keyCode).
   *
   * I've tried manually dispatching a KeyboardEvent with the correct keyCode to step outside
   * the testing-library box for this singular test but it is not currently working. Will revisit.
   *
   * See: https://github.com/moroshko/react-autosuggest/blob/master/src/Autosuggest.js#L713
   * See: https://github.com/testing-library/user-event/issues/842
   */
  it.skip('selects a value with keydown without specifying text', async () => {
    const [{ label: labelOne }] = checkboxes;
    const { user } = setup(component);

    const input = screen.getByRole('textbox');

    const queryOptions = { name: labelOne };
    const checkbox = screen.getByRole('checkbox', queryOptions);
    // unselect checkbox for the test first
    await user.click(checkbox);
    expect(
      screen.queryByRole('checkbox', queryOptions),
    ).not.toBeInTheDocument();

    await user.tab();
    // expect first item to be highlighted, so it can be selected
    expect(screen.getByRole('option', queryOptions)).toHaveAttribute(
      'aria-selected',
      'true',
    );
    expect(input).toHaveFocus();

    const event = new window.KeyboardEvent('keydown', {
      keyCode: 13,
      bubbles: true,
    });
    global.dispatchEvent(event);
    expect(screen.getAllByRole('checkbox', queryOptions)).toBeInTheDocument();
  });

  it('does not select value if no match exists and calls onChange prop if defined', async () => {
    const onChange = jest.fn();
    const { user } = setup(getComponent({ onChange }));

    const input = screen.getByRole('textbox');
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
