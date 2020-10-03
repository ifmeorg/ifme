// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputMocks } from 'mocks/InputMocks';
import { InputSubmit } from 'components/Input/InputSubmit';

const { id } = InputMocks.inputSubmitProps;
const { value } = InputMocks.inputSubmitProps;
const someEvent = InputMocks.event;

describe('InputSubmit', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  it('toggles clicking correctly', () => {
    const wrapper = shallow(
      <InputSubmit id={id} onClick={someEvent} value={value} />,
    );
    wrapper.find('input').simulate('click');
    expect(window.alert).toHaveBeenCalled();
    wrapper.find('input').simulate('click');
    expect(window.alert).toHaveBeenCalled();
  });
});
