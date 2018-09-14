// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputSubmit } from '../InputSubmit';
import { InputMocks } from '../../../mocks/InputMocks';

const { id } = InputMocks.inputSubmitProps;
const { name } = InputMocks.inputSubmitProps;
const { value } = InputMocks.inputSubmitProps;
const someEvent = InputMocks.event;

describe('InputSubmit', () => {
  beforeEach(() => {
    spyOn(window, 'alert');
  });

  it('toggles clicking correctly', () => {
    const wrapper = shallow(
      <InputSubmit
        id={id}
        onClick={someEvent}
        value={value}
      />,
    );
    wrapper.find('input').simulate('click');
    expect(window.alert).toHaveBeenCalled();
    wrapper.find('input').simulate('click');
    expect(window.alert).toHaveBeenCalled();
  });
});
