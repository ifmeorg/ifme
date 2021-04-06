// @flow
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import * as pell from 'pell';
import { InputMocks } from 'mocks/InputMocks';

describe('InputTextarea', () => {
  beforeAll(() => {
    // mocks obsolete method used internally in Pell
    document.queryCommandState = jest.fn();
    jest.spyOn(pell, 'init');
  });

  it('renders correctly', () => {
    const component = InputMocks.createInput(InputMocks.inputTextareaTemplateProps);
    const { container } = render(component);

    const textarea = screen.getByRole('textbox');
    expect(textarea).toBeInTheDocument();

    // Since '@testing-library/react' does not get hidden inputs,
    // it can be queried directly from the container for this test.
    const hiddenInput = container.querySelector('input[type="hidden"]');
    expect(hiddenInput).toBeInTheDocument();

    const editor = container.querySelector('.editor');
    expect(editor).toBeInTheDocument();
  });

  describe('editor', () => {
    it('initializes on mount', () => {
      const component = InputMocks.createInput(InputMocks.inputTextareaTemplateProps);
      const { container } = render(component);
      const editor = container.querySelector('.editor');
      expect(pell.init).toHaveBeenCalledWith(
        expect.objectContaining({ element: editor }),
      );
    });

    it('has a tab index and focuses', () => {
      const component = InputMocks.createInput(InputMocks.inputTextareaTemplateProps);
      render(component);
      // first tab should focus the editor textarea
      const textarea = screen.getByRole('textbox');
      userEvent.tab();
      userEvent.tab();
      expect(textarea).toHaveFocus();
    });

    describe('if required', () => {
      const { id } = InputMocks.inputTextareaTemplateProps;
      const onError = jest.fn();

      afterEach(() => {
        onError.mockClear();
      });

      describe('on blurring', () => {
        afterEach(() => {
          onError.mockClear();
        });

        it('handles error when empty', () => {
          const component = InputMocks.createInput(
            InputMocks.inputTextareaTemplateProps,
            { required: true, onError },
          );
          render(component);
          const textarea = screen.getByRole('textbox');
          userEvent.click(textarea);
          userEvent.tab();

          expect(onError).toHaveBeenCalledWith(id, true);
        });

        it('does not handle error when a value exists', () => {
          const component = InputMocks.createInput(
            InputMocks.inputTextareaTemplateProps,
            { required: true, onError, value: 'Some value' },
          );
          render(component);
          const textarea = screen.getByRole('textbox');
          userEvent.click(textarea);
          userEvent.tab();

          expect(onError).toHaveBeenCalledWith(id, false);
        });
      });

      it('on focusing resets error', () => {
        const component = InputMocks.createInput(
          InputMocks.inputTextareaTemplateProps,
          { required: true, onError },
        );
        render(component);
        // triggers focus
        const textarea = screen.getByRole('textbox');
        userEvent.click(textarea);
        expect(onError).toHaveBeenCalledWith(id, false);
      });
    });

    describe('if not required', () => {
      const onError = jest.fn();

      afterEach(() => {
        onError.mockClear();
      });

      describe('on blurring', () => {
        afterEach(() => {
          onError.mockClear();
        });

        it('does not handle error', () => {
          const component = InputMocks.createInput(
            InputMocks.inputTextareaTemplateProps,
            { required: false, onError },
          );
          render(component);
          // triggers focus, then blur
          const textarea = screen.getByRole('textbox');
          userEvent.click(textarea);
          userEvent.tab();
          expect(onError).not.toHaveBeenCalled();
        });
      });

      it('on focusing does not reset error', () => {
        const component = InputMocks.createInput(
          InputMocks.inputTextareaTemplateProps,
          { required: false, onError },
        );
        render(component);
        // triggers focus
        const textarea = screen.getByRole('textbox');
        userEvent.click(textarea);
        expect(onError).not.toHaveBeenCalled();
      });
    });

    it('handles formatting actions', () => {
      const sampleUrl = 'sample-url';
      jest.spyOn(pell, 'exec');
      // mocks prompting the user for link url
      jest.spyOn(window, 'prompt').mockImplementationOnce(() => sampleUrl);
      render(InputMocks.createInput(InputMocks.inputTextareaTemplateProps));

      const buttons = [
        // default actions
        { title: 'Bold', expectedArgs: ['bold'] },
        // overridden actions
        { title: 'Link', expectedArgs: ['createLink', sampleUrl] },
        { title: 'Ordered List', expectedArgs: ['insertOrderedList'] },
        { title: 'Unordered List', expectedArgs: ['insertUnorderedList'] },
      ];

      buttons.forEach(({ title, expectedArgs }) => {
        const button = screen.getByTitle(title);
        userEvent.click(button);
        expect(pell.exec).toHaveBeenCalledWith(...expectedArgs);
      });
    });
  });
});
