// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Form, hasErrors } from '../index';
import { InputMocks } from '../../../mocks/InputMocks';

// TODO (julianguyen): Include textarea once mocking draft-js works

const component = (
  <Form
    inputs={[
      Object.assign({}, InputMocks.inputTextProps, { required: true }),
      InputMocks.inputSelectProps,
      Object.assign({}, InputMocks.inputCheckboxGroupProps, { required: true }),
      InputMocks.inputSubmitProps,
    ]}
  />
);

describe('Form', () => {
  it('has no errors when submit is clicked', () => {
    const wrapper = mount(component);
    wrapper.find('input[name="some-text-name"]').prop('onChange')({
      currentTarget: { value: 'Hello' },
    });
    expect(hasErrors(wrapper.state().errors)).toEqual(0);
    wrapper.find('input[type="submit"]').prop('onClick');
    expect(hasErrors(wrapper.state().errors)).toEqual(0);
  });

  it('has errors when submit is clicked', () => {
    const wrapper = mount(component);
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
