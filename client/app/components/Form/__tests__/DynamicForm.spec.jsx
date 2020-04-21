// @flow
import { mount } from 'enzyme';
import React from 'react';
import { act } from 'react-dom/test-utils';
import DynamicForm from '../DynamicForm';
import { InputMocks } from '../../../mocks/InputMocks';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const defaultMockInputs = [
  { ...InputMocks.inputTextProps, required: true },
  InputMocks.inputSelectProps,
  { ...InputMocks.inputCheckboxGroupProps, required: true },
  InputMocks.inputTagProps,
  InputMocks.inputSwitchProps,
  InputMocks.inputSubmitProps,
];

const getMockInputs = (nameValue) => {
  if (nameValue) {
    return [
      {
        id: 'name-id',
        type: 'text',
        name: 'name',
        label: 'Name',
        placeholder: 'Some Name Placeholder',
        info: 'Some Name Info',
        required: true,
      },
      ...defaultMockInputs,
    ];
  }
  return defaultMockInputs;
};

const getComponent = (options = {}) => {
  const mockInputs = getMockInputs(options.nameValue);
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
      act(() => wrapper.find('input[name="some-text-name"]').prop('onBlur')({
        currentTarget: { value: 'Hello' },
      }));
      expect(wrapper.find('.error').length).toBe(0);
      wrapper.find('input[type="submit"]').prop('onClick');
      expect(wrapper.find('.error').length).toBe(0);
    });

    it('has errors when submit is clicked', () => {
      const wrapper = mount(getComponent());
      expect(wrapper.find('.error').length).toBe(0);
      act(() => wrapper
        .find('input[type="checkbox"][name="some-checkbox-one-name"]')
        .prop('onChange')({
          currentTarget: { checked: false },
        }));
      wrapper.find('input[type="submit"]').simulate('click');
      expect(wrapper.find('.error').length).toBe(2);
    });
  });

  describe('when nameValue exists', () => {
    it('has no errors when submit is clicked', () => {
      const wrapper = mount(getComponent({ nameValue: 'Name' }));
      act(() => wrapper.find('input[name="some-text-name"]').prop('onBlur')({
        currentTarget: { value: 'Hello' },
      }));
      expect(wrapper.find('.error').length).toBe(0);
      wrapper.find('input[type="submit"]').prop('onClick');
      expect(wrapper.find('.error').length).toBe(0);
    });

    it('has errors when submit is clicked', () => {
      const wrapper = mount(getComponent({ nameValue: 'Name' }));
      expect(wrapper.find('.error').length).toBe(0);
      act(() => wrapper
        .find('input[type="checkbox"][name="some-checkbox-one-name"]')
        .prop('onChange')({
          currentTarget: { checked: false },
        }));
      wrapper.find('input[type="submit"]').simulate('click');
      expect(wrapper.find('.error').length).toBe(2);
    });
  });
});
