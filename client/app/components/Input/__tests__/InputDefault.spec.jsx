// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { InputDefault } from '../InputDefault';
import { InputMocks } from '../../../mocks/InputMocks';

const { id } = InputMocks.inputTextProps;
const { name } = InputMocks.inputTextProps;
const { label } = InputMocks.inputTextProps;
const { info } = InputMocks.inputTextProps;
const { placeholder } = InputMocks.inputTextProps;
const someEvent = (error: boolean) => {
  window.alert(`Error is ${error}`);
};

describe('InputDefault', () => {
  beforeEach(() => {
    jest.spyOn(window, 'alert');
  });

  describe('has invalid type prop', () => {
    it('does not render', () => {
      const wrapper = shallow(
        <InputDefault
          id={id}
          type="invalid"
          name={name}
          label={label}
          placeholder={placeholder}
          required
          info={info}
          hasError={someEvent}
        />,
      );
      expect(wrapper.find('input').exists()).toEqual(false);
    });
  });

  describe('has valid type prop', () => {
    it('calls hasError prop when value prop is empty', () => {
      const wrapper = shallow(
        <InputDefault
          id={id}
          type="text"
          name={name}
          label={label}
          placeholder={placeholder}
          required
          info={info}
          hasError={someEvent}
        />,
      );
      wrapper
        .find('input')
        .simulate('blur', { currentTarget: { value: 'Some Value' } });
      expect(window.alert).toHaveBeenCalledWith('Error is false');
      wrapper.find('input').simulate('blur', { currentTarget: { value: '' } });
      expect(window.alert).toHaveBeenCalledWith('Error is true');
    });
  });

  describe('has valid copyOnClick prop', () => {
    it('copies to clipboard when input is clicked', () => {
      jest.spyOn(window, 'alert');
      jest.spyOn(window.document, 'execCommand');
      const copyOnClick = 'Some message';
      const wrapper = shallow(
        <InputDefault
          id={id}
          type="text"
          name={name}
          copyOnClick={copyOnClick}
        />,
      );
      wrapper.find('input').simulate('click', {
        currentTarget: {
          value: 'test',
          select: () => {},
        },
      });
      expect(window.document.execCommand).toHaveBeenCalledWith('copy');
      expect(window.alert).toHaveBeenCalledWith(copyOnClick);
    });
  });
});
