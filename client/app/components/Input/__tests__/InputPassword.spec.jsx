// @flow
import React from 'react';
import { mount, shallow } from 'enzyme';
import { act } from 'react-dom/test-utils';
import { InputMocks } from '../../../mocks/InputMocks';
import { InputPassword } from '../InputPassword';

const { id, name, label } = InputMocks.inputPasswordProps;

describe('InputPassword', () => {
  it('toggles show password button correctly', () => {
    const component = InputMocks.createInput(InputMocks.inputPasswordProps);
    const wrapper = mount(component);
    expect(wrapper.find('input').props().type).toEqual('password');
    expect(wrapper.find('button').props()['aria-label']).toEqual(
      'Show password',
    );
    wrapper.find('button').simulate('click');
    expect(wrapper.find('input').props().type).toEqual('text');
    expect(wrapper.find('button').props()['aria-label']).toEqual(
      'Hide password',
    );
  });

  describe('when input is not required', () => {
    const component = (
      <InputPassword
        id={id}
        name={name}
        label={label}
        hasError={(error) => {
          window.alert(error);
        }}
      />
    );

    beforeEach(() => {
      jest.spyOn(window, 'alert');
    });

    describe('on input focus', () => {
      it('has no error', () => {
        const wrapper = shallow(component);
        act(() => {
          wrapper.find('input').simulate('focus');
        });
        expect(window.alert).not.toHaveBeenCalled();
      });
    });

    describe('on input blur', () => {
      it('has an error when there is no value', () => {
        const wrapper = shallow(component);
        act(() => {
          wrapper.find('input').simulate('blur', {
            currentTarget: {
              value: null,
            },
          });
        });
        expect(window.alert).not.toHaveBeenCalled();
      });

      it('has no error when there is a value', () => {
        const wrapper = shallow(component);
        act(() => {
          wrapper.find('input').simulate('blur', {
            currentTarget: {
              value: 'Some value',
            },
          });
        });
        expect(window.alert).not.toHaveBeenCalled();
      });
    });
  });

  describe('when input is required', () => {
    const component = (
      <InputPassword
        id={id}
        name={name}
        label={label}
        hasError={(error) => {
          window.alert(error);
        }}
        required
      />
    );

    beforeEach(() => {
      jest.spyOn(window, 'alert');
    });

    describe('on input focus', () => {
      it('has no error', () => {
        const wrapper = shallow(component);
        act(() => {
          wrapper.find('input').simulate('focus');
        });
        expect(window.alert).toHaveBeenCalledWith(false);
      });
    });

    describe('on input blur', () => {
      it('has an error when there is no value', () => {
        const wrapper = shallow(component);
        act(() => {
          wrapper.find('input').simulate('blur', {
            currentTarget: {
              value: null,
            },
          });
        });
        expect(window.alert).toHaveBeenCalledWith(true);
      });

      it('has no error when there is a value', () => {
        const wrapper = shallow(component);
        act(() => {
          wrapper.find('input').simulate('blur', {
            currentTarget: {
              value: 'Some value',
            },
          });
        });
        expect(window.alert).toHaveBeenCalledWith(false);
      });
    });
  });
});
