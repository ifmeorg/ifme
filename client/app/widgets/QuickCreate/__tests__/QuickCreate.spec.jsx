import React from 'react';
import { mount } from 'enzyme';
import { render, screen, getNodeText } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { QuickCreate } from 'widgets/QuickCreate';

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
  let wrapper;
  beforeEach(() => {
    render(
      <QuickCreate
        name="name"
        id="123"
        label="label"
        checkboxes={checkboxes}
        formProps={{ inputs: [{}] }}
      />
    );
    wrapper = mount(
      <QuickCreate
        name="name"
        id="123"
        label="label"
        checkboxes={checkboxes}
        formProps={{ inputs: [{}] }}
      />
    );
  });

  afterEach(() => {
    jest.restoreAllMocks();
    wrapper.unmount();
  });
  describe('When the component renders', () => {
    it('renders an input with a label with the accordion closed', () => {
      expect(screen.getByTestId('accordion-closed')).toBeTruthy();
      expect(getNodeText(screen.getByText('label'))).toEqual('label');
    });
    it('renders checkboxes sorted by label when initially rendered with some checked checkbox props', () => {
      const someCheckedCheckboxes = [
        ...checkboxes,
        {
          id: 'zoo',
          value: 'zoo',
          label: 'zoos',
          checked: true,
        },
        {
          id: 'apple',
          value: 'apple',
          label: 'apple',
          checked: true,
        },
      ];
      render(
        <QuickCreate
          name="name"
          id="123"
          label="label"
          checkboxes={someCheckedCheckboxes}
          formProps={{ inputs: [{}] }}
        />
      );
      const renderedCheckboxes = screen.getAllByRole('checkbox');
      expect(renderedCheckboxes[0]).toHaveAttribute('value', 'apple');
      expect(renderedCheckboxes[1]).toHaveAttribute('value', 'zoo');
    });
  });
  describe('when accordion is clicked', () => {
    it('it opens and the user can interact with the textbox', () => {
      // user clicks on the label to open accordion
      userEvent.click(screen.getByText('label'));
      // accordion reflects open state
      screen.getByTestId('accordion-open'); // may not be necessary, if the textbox is visible the accordion is working
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
      // type a value that doesn't exist as a checkbox
      const textbox = screen.getByRole('textbox');
      const newCheckboxValue = 'new checkbox';
      userEvent.type(textbox, `${newCheckboxValue}{enter}`);
      screen.debug(screen.getByRole('dialog'));
      screen.debug(screen.getAllByDisplayValue(newCheckboxValue));
    });
    it('does not open the modal if the label already exists', () => {});
  });

  it('opens modal and displays quick create form if label does not exist', () => {});

  it('renders with the accordion initially closed', () => {
    // const modal = wrapper.find('Modal');
    // expect(modal).toHaveLength(1);
    // expect(modal.prop('open')).toBe(false);
  });

  describe('when input is changed', () => {
    // function changeInput(label) {
    //   expect(wrapper.find('DynamicForm')).toHaveLength(0);
    //   expect(wrapper.find('Modal').prop('open')).toBe(false);
    //   wrapper.find('Input').prop('onChange')({
    //     checkboxes,
    //     label,
    //   });
    //   wrapper.update();
    // }

    it('opens modal and displays quick create form if label does not exist', () => {
      // changeInput('new_label');
      // expect(wrapper.find('Modal').prop('open')).toBe(true);
      // expect(wrapper.find('DynamicForm')).toHaveLength(1);
    });

    it('does not open the modal if the label already exists', () => {
      // changeInput('alpha_label');
      // expect(wrapper.find('Modal').prop('open')).toBe(false);
      // expect(wrapper.find('DynamicForm')).toHaveLength(0);
    });
  });

  describe('when the form is submitted', () => {
    // function submitForm(data) {
    //   wrapper.find('DynamicForm').prop('onSubmit')({
    //     data: data || {
    //       success: true,
    //       name: 'new_label',
    //       id: 'new_value',
    //       slug: 'new_id',
    //     },
    //   });
    //   wrapper.update();
    // }

    beforeEach(() => {
      // // make the DynamicForm render
      // wrapper.find('Input').prop('onChange')({
      //   checkboxes,
      //   label: 'new_label',
      // });
      // wrapper.update();
    });

    it('adds checkboxes from data', () => {
      // const spy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      // expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(4);
      // submitForm();
      // expect(wrapper.find('Input').prop('checkboxes')).toHaveLength(5);
      // expect(spy).toHaveBeenCalledTimes(1);
    });

    it('opens the accordion, closes the modal, and assigns the correct key to the modal and input field', () => {
      // let input = wrapper.find('Input');
      // let modal = wrapper.find('Modal');
      // expect(input.prop('accordionOpen')).toBe(false);
      // expect(modal.prop('open')).toBe(true);
      // submitForm();
      // input = wrapper.find('Input');
      // modal = wrapper.find('Modal');
      // expect(modal.prop('open')).toBe(false);
      // expect(input.prop('accordionOpen')).toBe(true);
      // expect(modal.key()).toBe(wrapper.state('modalKey'));
    });

    it('does not submit the form when response data is invalid', () => {
      // const spy = jest.spyOn(wrapper.instance(), 'addToCheckboxes');
      // let input = wrapper.find('Input');
      // let modal = wrapper.find('Modal');
      // expect(input.prop('accordionOpen')).toBe(false);
      // expect(modal.prop('open')).toBe(true);
      // submitForm({ success: false });
      // input = wrapper.find('Input');
      // modal = wrapper.find('Modal');
      // expect(modal.prop('open')).toBe(true);
      // expect(input.prop('accordionOpen')).toBe(false);
      // expect(spy).toHaveBeenCalledTimes(0);
    });
  });
});
