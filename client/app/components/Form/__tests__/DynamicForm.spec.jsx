// @flow
import { mount } from 'enzyme';
import React from 'react';
import { DynamicForm, hasErrors } from '../DynamicForm';
import { InputMocks } from '../../../mocks/InputMocks';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const mockInputs = [
  { ...InputMocks.inputTextProps, required: true },
  InputMocks.inputSelectProps,
  { ...InputMocks.inputCheckboxGroupProps, required: true },
  InputMocks.inputTagProps,
  InputMocks.inputSwitchProps,
  InputMocks.inputSubmitProps,
];

const getComponent = (options = {}) => {
  if (options.nameValue) {
    mockInputs.unshift({
      id: 'name-id',
      type: 'text',
      name: 'name',
      label: 'Name',
      placeholder: 'Some Name Placeholder',
      info: 'Some Name Info',
      required: true,
    });
  }
  return (
    <DynamicForm
      nameValue={options.nameValue}
      formProps={{
        action: '/fake-action',
        inputs: mockInputs,
      }}
      onCreate={() => {}}
    />
  );
};

describe('Form', () => {
  describe('when nameValue does not exist', () => {
    it('has no errors when submit is clicked', () => {
      const wrapper = mount(getComponent());
      wrapper.find('input[name="some-text-name"]').prop('onBlur')({
        currentTarget: { value: 'Hello' },
      });
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper.find('input[type="submit"]').prop('onClick');
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
    });

    it('has errors when submit is clicked', () => {
      const wrapper = mount(getComponent());
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper
        .find('input[type="checkbox"][name="some-checkbox-one-name"]')
        .prop('onChange')({
          currentTarget: { checked: false },
        });
      wrapper.find('input[type="submit"]').simulate('click');
      expect(hasErrors(wrapper.state().errors)).toEqual(2);
    });
  });

  describe('when nameValue exists', () => {
    it('has no errors when submit is clicked', () => {
      const wrapper = mount(getComponent({ nameValue: 'Name' }));
      wrapper.find('input[name="some-text-name"]').prop('onBlur')({
        currentTarget: { value: 'Hello' },
      });
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper.find('input[type="submit"]').prop('onClick');
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
    });

    it('has errors when submit is clicked', () => {
      const wrapper = mount(getComponent({ nameValue: 'Name' }));
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper
        .find('input[type="checkbox"][name="some-checkbox-one-name"]')
        .prop('onChange')({
          currentTarget: { checked: false },
        });
      wrapper.find('input[type="submit"]').simulate('click');
      expect(hasErrors(wrapper.state().errors)).toEqual(2);
    });
  });
});
