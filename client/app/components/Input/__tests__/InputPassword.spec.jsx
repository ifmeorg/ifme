// @flow
import { mount } from 'enzyme';
import { InputMocks } from '../../../mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputPasswordProps);

describe('InputPassword', () => {
  it('toggles correctly', () => {
    const wrapper = mount(component);

    // wrapper
    //   .find('input')
    //   .simulate('change', { currentTarget: { value: 'some value' } });

    wrapper
      .find('i')
      .simulate('click');
    expect(wrapper.find('input').props().value).toEqual('some-password-text');
    expect(wrapper.find('input').props().type).toEqual('password');
    expect(wrapper.find('i').props().className).toEqual('fa fa-eye-slash');

    wrapper
      .find('i')
      .simulate('click');
    expect(wrapper.find('input').props().value).toEqual('some-password-text');
    expect(wrapper.find('input').props().type).toEqual('text');
    expect(wrapper.find('i').props().className).toEqual('fa fa-eye');
  });
});
