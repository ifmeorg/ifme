// @flow
import { mount } from 'enzyme';
import { InputMocks } from '../../../mocks/InputMocks';

describe('Input', () => {
  describe('InputDefault', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          InputMocks.createInput(InputMocks.inputTextProps, {
            accordion: true,
          }),
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
      });
    });
  });

  describe('CheckboxGroup', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          InputMocks.createInput(InputMocks.inputCheckboxGroupProps, {
            accordion: true,
          }),
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
      });
    });
  });

  describe('Select', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          InputMocks.createInput(InputMocks.inputSelectProps, {
            accordion: true,
          }),
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('select')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('select')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('select')
            .exists(),
        ).toEqual(false);
      });
    });
  });

  describe('Tag', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          InputMocks.createInput(InputMocks.inputTagProps, {
            accordion: true,
          }),
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('input')
            .exists(),
        ).toEqual(false);
      });
    });
  });

  describe('Switch', () => {
    describe('with accordion prop', () => {
      it('toggles correctly', () => {
        const wrapper = mount(
          InputMocks.createInput(InputMocks.inputSwitchProps, {
            accordion: true,
          }),
        );
        expect(
          wrapper
            .find('.accordionContent')
            .find('.switch')
            .exists(),
        ).toEqual(false);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('.switch')
            .exists(),
        ).toEqual(true);
        wrapper.find('.accordion').simulate('click');
        expect(
          wrapper
            .find('.accordionContent')
            .find('.switch')
            .exists(),
        ).toEqual(false);
      });
    });
  });
});
