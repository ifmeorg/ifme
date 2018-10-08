// @flow
import { mount } from 'enzyme';
import { InputMocks } from '../../../mocks/InputMocks';

const component = InputMocks.createInput(InputMocks.inputSwitchProps);
const input = `input#${InputMocks.inputSwitchProps.id}`;

describe('InputSwitch', () => {
  describe('with mouse', () => {
    it('toggles correctly', () => {
      const wrapper = mount(component);
      expect(wrapper.find(input).props().defaultChecked).toEqual(false);
      wrapper.find('.switchToggle').simulate('click');
      expect(wrapper.find(input).props().defaultChecked).toEqual(true);
      wrapper.find('.switchToggle').simulate('click');
      expect(wrapper.find(input).props().defaultChecked).toEqual(false);
    });
  });

  describe('with keyboard', () => {
    it('toggles correctly', () => {
      const wrapper = mount(component);
      expect(wrapper.find(input).props().defaultChecked).toEqual(false);
      wrapper.find('.switchToggle').simulate('keypress', { key: 'Enter' });
      expect(wrapper.find(input).props().defaultChecked).toEqual(true);
      wrapper.find('.switchToggle').simulate('keypress', { key: 'Enter' });
      expect(wrapper.find(input).props().defaultChecked).toEqual(false);
    });
  });
});
