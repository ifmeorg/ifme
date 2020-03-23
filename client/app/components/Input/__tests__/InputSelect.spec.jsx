// @flow
import React from 'react';
import { shallow } from 'enzyme';
import { act } from 'react-dom/test-utils';
import { InputSelect } from '../InputSelect';
import { InputMocks } from '../../../mocks/InputMocks';

const {
  id, name, ariaLabel, value, options,
} = InputMocks.inputSelectProps;
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
    act(() => {
      wrapper
        .find('select')
        .simulate('change', { currentTarget: { value: options[1].value } });
    });
    expect(window.alert).toHaveBeenCalled();
    act(() => {
      wrapper
        .find('select')
        .simulate('change', { currentTarget: { value: options[0].value } });
    });
    expect(window.alert).toHaveBeenCalled();
  });
});
