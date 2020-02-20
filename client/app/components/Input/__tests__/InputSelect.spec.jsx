// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputSelect } from '../InputSelect';
import { InputMocks } from '../../../mocks/InputMocks';

const { id } = InputMocks.inputSelectProps;
const { name } = InputMocks.inputSelectProps;
const { ariaLabel } = InputMocks.inputSelectProps;
const { value } = InputMocks.inputSelectProps;
const { options } = InputMocks.inputSelectProps;
const someEvent = InputMocks.event;

describe('InputSelect', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  it('toggles options correctly', () => {
    const wrapper = shallow(
      <InputSelect
        name={name}
        id={id}
        ariaLabel={ariaLabel}
        value={value}
        options={options}
        onChange={someEvent}
      />,
    );
    wrapper
      .find('select')
      .simulate('change', { currentTarget: { value: options[1].value } });
    expect(window.alert).toHaveBeenCalled();
    expect(wrapper.state('value')).toEqual(options[1].value);
    wrapper
      .find('select')
      .simulate('change', { currentTarget: { value: options[0].value } });
    expect(window.alert).toHaveBeenCalled();
    expect(wrapper.state('value')).toEqual(options[0].value);
  });
});
