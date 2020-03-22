// @flow
import { mount } from 'enzyme';
import { InputMocks } from '../../../mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputPasswordProps);

describe('InputPassword', () => {
  it('toggles show password button correctly', () => {
    const wrapper = mount(component);
    expect(wrapper.find('input').props().type).toEqual('password');
    expect(wrapper.find('i').props().className).toEqual('fa fa-eye-slash');
    wrapper.find('button').simulate('click');
    expect(wrapper.find('input').props().type).toEqual('text');
    expect(wrapper.find('i').props().className).toEqual('fa fa-eye');
  });
});
