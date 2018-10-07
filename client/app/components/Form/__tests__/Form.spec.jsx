// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Form, hasErrors } from '../index';
import { InputMocks } from '../../../mocks/InputMocks';

// TODO (julianguyen): Include InputTextarea after writing stubs for pell editor

const component = (noFormTag: boolean) => (
  <Form
    action={noFormTag ? undefined : '/post-wont-work'}
    noFormTag={noFormTag}
    inputs={[
      Object.assign({}, InputMocks.inputTextProps, { required: true }),
      InputMocks.inputSelectProps,
      Object.assign({}, InputMocks.inputCheckboxGroupProps, { required: true }),
      InputMocks.inputTagProps,
      InputMocks.inputSwitchProps,
      InputMocks.inputSubmitProps,
    ]}
  />
);

describe('Form', () => {
  describe('when noFormTag prop is true', () => {
    it('has no errors when submit is clicked', () => {
      const wrapper = mount(component(true));
      wrapper.find('input[name="some-text-name"]').prop('onBlur')({
        currentTarget: { value: 'Hello' },
      });
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper.find('input[type="submit"]').prop('onClick');
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
    });

    it('has errors when submit is clicked', () => {
      const wrapper = mount(component(true));
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

  describe('when noFormTag prop is false', () => {
    it('has no errors when submit is clicked', () => {
      const wrapper = mount(component(false));
      wrapper.find('input[name="some-text-name"]').prop('onBlur')({
        currentTarget: { value: 'Hello' },
      });
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper.find('input[type="submit"]').simulate('click');
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
    });

    it('has errors when submit is clicked', () => {
      const wrapper = mount(component(false));
      expect(hasErrors(wrapper.state().errors)).toEqual(0);
      wrapper
        .find('input[type="checkbox"][name="some-checkbox-one-name"]')
        .prop('onChange')({
          currentTarget: { checked: false },
        });
      wrapper.find('input[type="submit"]').simulate('submit');
      expect(hasErrors(wrapper.state().errors)).toEqual(2);
    });
  });
});
