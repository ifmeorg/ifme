import React from 'react';
import axios from 'axios';
import {
  render,
  screen,
  waitForElementToBeRemoved,
  waitFor,
} from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import {
  QuickCreate,
  sortAlpha,
  labelExists,
  addToCheckboxes,
} from 'widgets/QuickCreate';

const checkboxes = [
  { id: 'last', value: 'a_value', label: 'zoo_label' },
  { id: 'middle', value: 'middle_value', label: 'middle_label' },
  { id: 'first', value: 'z_value', label: 'alpha_label' },
  { id: 'dm', value: 'duplicate_middle_value', label: 'middle_label' },
];

describe('QuickCreate', () => {
  beforeEach(() => {
    render(
      <QuickCreate
        name="name"
        id="123"
        label="label"
        checkboxes={checkboxes}
        formProps={{
          inputs: [
            {
              id: 'category_name',
              label: 'Name',
              name: 'category[name]',
              required: true,
              type: 'text',
              value: '',
            },
            {
              id: 'submit',
              name: 'submit',
              type: 'submit',
              value: 'Submit',
            },
          ],
          action: 'https://if-me.org/quick-create',
        }}
      />,
    );
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  describe('When the component renders', () => {
    it('renders an input with a label with the accordion closed', () => {
      expect(screen.getByRole('button')).toHaveAttribute(
        'aria-expanded',
        'false',
      );
      expect(screen.getByText('label')).toBeInTheDocument();
    });
  });

  describe('when accordion is clicked', () => {
    it('it opens and the user can interact with the textbox', () => {
      expect(screen.getByRole('button')).toHaveAttribute(
        'aria-expanded',
        'false',
      );
      const quickCreateButton = screen.getByRole('button');
      // user clicks on the button to open accordion
      userEvent.click(quickCreateButton);
      // accordion reflects open state
      expect(screen.getByRole('button')).toHaveAttribute(
        'aria-expanded',
        'true',
      );
      const userInput = 'my input text';
      // User enters some text
      userEvent.type(screen.getByRole('textbox'), userInput);
      // Closes the input
      userEvent.click(quickCreateButton);
      // Reopen
      userEvent.click(quickCreateButton);
      expect(screen.getByRole('textbox')).toHaveValue(userInput);
    });
  });

  describe('when input is changed', () => {
    it('opens modal when the checkbox does not already exist', () => {
      // open accordion
      userEvent.click(screen.getByRole('button'));
      // modal does not exist yet
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
      // user enters a checkbox value that does not exist
      userEvent.type(screen.getByRole('textbox'), 'new checkbox{enter}');
      // modal appears
      expect(screen.getByRole('dialog')).toBeInTheDocument();
    });

    it('does not open the modal if the checkbox already exists', () => {
      const [{ label }] = checkboxes;
      // open accordion
      userEvent.click(screen.getByRole('button'));
      // type a value that already exists
      userEvent.type(screen.getByRole('textbox'), `${label}{enter}`);
      // modal should not be open
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });

    it('does not open modal if input matches an unselected option', () => {
      const [, { label }] = checkboxes;
      // open accordion
      userEvent.click(screen.getByRole('button'));
      expect(
        screen.queryByRole('checkbox', {
          name: label,
        }),
      ).not.toBeInTheDocument();
      // type a value that already exists
      userEvent.type(screen.getByRole('textbox'), `${label}{enter}`);
      expect(
        screen.getByRole('checkbox', {
          name: label,
        }),
      ).toBeInTheDocument();
      // modal should not be open
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });
  });

  describe('when the form', () => {
    it('is submitted it adds a new checkbox from data', async () => {
      const response = {
        data: {
          success: true,
          id: 1,
          name: 'new checkbox',
          slug: 'new-checkbox',
        },
      };
      const axiosPostSpy = jest
        .spyOn(axios, 'post')
        .mockResolvedValue(response);
      // open accordion
      userEvent.click(screen.getByRole('button'));
      // enter a value that does not exist
      userEvent.type(screen.getByRole('textbox'), 'new checkbox{enter}');
      // dialog for new checkbox appears
      expect(screen.getByRole('dialog')).toBeInTheDocument();
      // submit the form
      userEvent.click(screen.getByRole('button', { name: 'Submit' }));
      // when the dialog has been removed there was a successful submission
      await waitForElementToBeRemoved(() => screen.getByRole('dialog'));
      expect(axiosPostSpy).toBeCalledWith('https://if-me.org/quick-create', {
        category: { name: 'new checkbox' },
      });
      // accordion is still open
      expect(screen.getByRole('button')).toHaveAttribute(
        'aria-expanded',
        'true',
      );
      // newly created checkbox is checked
      expect(
        screen.getByRole('checkbox', {
          name: 'new checkbox',
        }),
      ).toBeChecked();
    });

    it('submission fails the modal stays open', async () => {
      const response = {
        error: 'some error',
      };
      const axiosPostSpy = jest
        .spyOn(axios, 'post')
        .mockRejectedValue(response);
      // open accordion
      userEvent.click(screen.getByRole('button'));
      // enter a checkbox that does not exist
      userEvent.type(screen.getByRole('textbox'), 'new checkbox{enter}');
      // submit
      userEvent.click(screen.getByRole('button', { name: 'Submit' }));
      await waitFor(() => expect(axiosPostSpy).toHaveBeenCalled());
      // modal is still up when the request fails
      expect(screen.getByRole('dialog')).toBeInTheDocument();
    });
  });

  describe('QuickCreate utils', () => {
    it('sortAlpha sorts checkboxes alphabetically (asc)', () => {
      const result = sortAlpha([
        ...checkboxes,
        { label: 'a', id: 'a', value: 'a' },
      ]);
      expect(result[0].label).toEqual('a');
      expect(result[1]).toEqual(checkboxes[2]);
    });

    it('labelExists returns if a specific label exists in an array of checkboxes', () => {
      const result = labelExists(checkboxes, 'zoo_label');
      expect(result).toBe(true);
    });
    it('labelExists returns true if more than one of the same label exists in checkboxes', () => {
      const result = labelExists(checkboxes, 'middle_label');
      expect(result).toBe(true);
    });

    it('addToCheckboxes shallow copies an array of checkboxes, pushes a new checkbox, and sorts them', () => {
      const result = addToCheckboxes(
        { name: 'a', id: 'a', slug: 'a' },
        checkboxes,
      );
      expect(result[0].label).toEqual('a');
      expect(result).not.toBe(checkboxes);
      expect(result[1]).toEqual(checkboxes[2]);
      expect(result.length).toEqual(checkboxes.length + 1);
    });
  });
});
