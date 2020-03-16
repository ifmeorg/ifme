// @flow
import { mount } from 'enzyme';
import React from 'react';
import { act } from 'react-dom/test-utils';
import Form from '../index';
import { InputMocks } from '../../../mocks/InputMocks';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const getComponent = () => (
  <Form
    action="/fake-action"
    inputs={[
      { ...InputMocks.inputTextProps, required: true },
      InputMocks.inputSelectProps,
      { ...InputMocks.inputCheckboxGroupProps, required: true },
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputSubmitProps,
    ]}
  />
);

describe('Form', () => {
  it('has no errors when submit is clicked', () => {
    const wrapper = mount(getComponent());
    act(() => wrapper.find('input[name="some-text-name"]').prop('onBlur')({
      currentTarget: { value: 'Hello' },
    }));
    expect(wrapper.find('.error').length).toBe(0);
    wrapper.find('input[type="submit"]').simulate('click');
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
    wrapper.find('input[type="submit"]').simulate('submit');
    expect(wrapper.find('.error').length).toBe(2);
  });
});
