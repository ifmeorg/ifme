// @flow
import { mount } from 'enzyme';
import { act } from 'react-dom/test-utils';
import { InputMocks } from '../../../mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputTagProps);

describe('InputTag', () => {
  it('type in value and select it', () => {
    const wrapper = mount(component);
    const id = `#${InputMocks.inputTagProps.checkboxes[1].id}`;
    const value = { value: 'Two' };
    expect(wrapper.find('.tagMenu').exists()).toEqual(true);
    act(() => {
      wrapper.find('.tagAutocomplete').simulate('change', { target: value });
    });
    wrapper.find('.tagAutocomplete').simulate('focus');
    expect(wrapper.find(id).exists()).toEqual(false);
    wrapper
      .find('.tagLabel')
      .at(0)
      .simulate('click');
    expect(wrapper.find(id).exists()).toEqual(true);
  });

  it('un-check existing value and retype and select it', () => {
    const wrapper = mount(component);
    const id = `input#${InputMocks.inputTagProps.checkboxes[0].id}`;
    const value = { value: 'One' };
    expect(wrapper.find(id).exists()).toEqual(true);
    act(() => {
      wrapper.find(id).prop('onChange')({ currentTarget: { checked: false } });
    });
    wrapper.update();
    expect(wrapper.find(id).exists()).toEqual(false);
    act(() => {
      wrapper.find('.tagAutocomplete').simulate('change', { target: value });
    });
    wrapper.find('.tagAutocomplete').simulate('focus');
    expect(wrapper.find('.tagMenu').exists()).toEqual(true);
    expect(wrapper.find(id).exists()).toEqual(false);
    wrapper
      .find('.tagLabel')
      .at(0)
      .simulate('click');
    expect(wrapper.find(id).exists()).toEqual(true);
  });
});
