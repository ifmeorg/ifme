// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import React from 'react';
import { InputMocks } from 'mocks/InputMocks';
import { InputDefault } from 'components/Input/InputDefault';

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

  afterEach(() => {
    window.alert.mockClear();
  });

  describe('has invalid type prop', () => {
    it('does not render', () => {
      render(
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
      expect(screen.queryByLabelText(label)).not.toBeInTheDocument();
    });
  });

  describe('has valid type prop', () => {
    it('calls hasError prop when value prop is empty', () => {
      render(
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
      const textInput = screen.getByRole('textbox', { name: label });
      expect(textInput).toBeInTheDocument();
      userEvent.type(textInput, 'Some Value');
      userEvent.tab();
      expect(window.alert).toHaveBeenCalledWith('Error is false');
      userEvent.clear(textInput);
      userEvent.tab();
      expect(window.alert).toHaveBeenCalledWith('Error is true');
    });
  });

  describe('has valid copyOnClick prop', () => {
    beforeEach(() => {
      jest.spyOn(window.document, 'execCommand');
    });

    afterEach(() => {
      window.document.execCommand.mockRestore();
    });

    it('copies to clipboard when input is clicked', () => {
      const copyOnClick = 'Some message';
      render(
        <InputDefault
          id={id}
          type="text"
          name={name}
          label={label}
          copyOnClick={copyOnClick}
        />,
      );
      const textInput = screen.getByRole('textbox', { name: label });
      userEvent.type(textInput, 'test');
      userEvent.click(textInput);
      expect(window.document.execCommand).toHaveBeenCalledWith('copy');
      expect(window.alert).toHaveBeenCalledWith(copyOnClick);
    });
  });
});
