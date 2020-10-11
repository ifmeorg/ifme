import React from 'react';
import axios from 'axios';
import {
  render,
  screen,
  getNodeText,
  waitForElementToBeRemoved,
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

// https://testing-library.com/docs/dom-testing-library/api-events#fireeventeventname
// from rtl docs Most projects have a few use cases for fireEvent, but the majority of the time
// you should probably use @testing-library/user-event.
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
      expect(screen.queryByTestId('accordion-closed')).toBeInTheDocument();
      expect(getNodeText(screen.getByText('label'))).toEqual('label');
    });
  });
  describe('when accordion is clicked', () => {
    it('it opens and the user can interact with the textbox', () => {
      expect(screen.queryByTestId('accordion-closed')).toBeInTheDocument();
      // user clicks on the label to open accordion
      userEvent.click(screen.getByText('label'));
      // accordion reflects open state
      expect(screen.queryByTestId('accordion-open')).toBeInTheDocument();
      // initially the user sees the placeholder text
      const input = screen.getByRole('textbox');

      const userInput = 'my input text';
      // User enters some text
      userEvent.type(input, userInput);
      // Closes the input
      userEvent.click(screen.getByText('label'));
      // Reopen
      userEvent.click(screen.getByText('label'));
      expect(screen.getByRole('textbox')).toHaveValue(userInput);
    });
  });
  describe('when input is changed', () => {
    it('opens modal and displays quick create form if label does not exist', () => {
      // open accordion
      userEvent.click(screen.getByText('label'));
      const textbox = screen.getByRole('textbox');
      // modal doesn't exist yet
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
      // user enters a checkbox value that does not exist
      userEvent.type(textbox, 'new checkbox{enter}');
      // modal appears
      expect(screen.queryByRole('dialog')).toBeInTheDocument();
    });
    it('does not open the modal if the label already exists', () => {
      // open accordion
      userEvent.click(screen.getByText('label'));
      const textbox = screen.getByRole('textbox');
      // type a value that already exists
      userEvent.type(textbox, `${checkboxes[0].label}{enter}`);
      // modal should not be open
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });
  });

  describe('when the form is submitted', () => {
    it('adds checkboxes from data', async () => {
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
        .mockImplementation(() => Promise.resolve(response));
      userEvent.click(screen.getByText('label'));
      const textbox = screen.getByRole('textbox');
      userEvent.type(textbox, 'new checkbox{enter}');
      userEvent.click(screen.getByRole('button', { name: 'Submit' }));
      // when the dialog has been removed there was a successful submission
      await waitForElementToBeRemoved(() => screen.getByRole('dialog'));
      expect(axiosPostSpy).toBeCalledWith('https://if-me.org/quick-create', {
        category: { name: 'new checkbox' },
      });
      // accordion is still open
      expect(screen.queryByTestId('accordion-open')).toBeInTheDocument();
      const newCheckbox = screen.getByRole('checkbox');
      // the value matches the response slug id
      expect(newCheckbox).toHaveAttribute('aria-label', 'new checkbox');
      // the checbox is also checked
      expect(newCheckbox).toBeChecked();
    });

    it('does not submit the form when response data is invalid', async () => {
      const response = {
        error: 'some error',
      };
      const axiosPostSpy = jest
        .spyOn(axios, 'post')
        .mockImplementation(() => Promise.resolve(response));
      userEvent.click(screen.getByText('label'));
      const textbox = screen.getByRole('textbox');
      userEvent.type(textbox, 'new checkbox{enter}');
      userEvent.click(screen.getByRole('button', { name: 'Submit' }));
      await axiosPostSpy();
      // modal is still up when the request fails
      expect(screen.queryByRole('dialog')).toBeInTheDocument();
    });
  });

  describe('QuickCreate utils', () => {
    it('sortAlpha sorts checkboxes alphabetically (asc)', () => {
      const result = sortAlpha([
        ...checkboxes,
        { label: 'a', id: 'a', value: 'a' },
      ]);
      expect(result[0].label).toEqual('a');
    });
    it('labelExists returns if a specific label exists in an array of checkboxes', () => {
      const result = labelExists(checkboxes, 'zoo_label');
      expect(result).toBeTruthy();
    });
    it('addToCheckboxes shallow copies an array of checkboxes, pushes a new checkbox, and sorts them', () => {
      const result = addToCheckboxes(
        { name: 'a', id: 'a', slug: 'a' },
        checkboxes,
      );
      expect(result[0].label).toEqual('a');
      expect(result[1]).toEqual(checkboxes[2]);
    });
  });
});
