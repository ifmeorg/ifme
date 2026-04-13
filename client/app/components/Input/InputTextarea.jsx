// @flow
import React, { useState, useEffect, useRef } from 'react';
import type { Node } from 'react';
import { sanitize } from 'dompurify';
import ReactDOMServer from 'react-dom/server';
import { init, exec } from 'pell';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faImage, faLink } from '@fortawesome/free-solid-svg-icons';
import css from './InputTextarea.scss';
import inputCss from './Input.scss';

const handleResult = (type: string) => {
  switch (type) {
    case 'link': {
      const url = window.prompt('URL');
      if (url) exec('createLink', url);
      break;
    }
    case 'image': {
      const src = window.prompt('Please provide a link to your image.');
      if (src) exec('insertImage', src);
      break;
    }
    case 'olist':
      exec('insertOrderedList');
      break;
    case 'ulist':
      exec('insertUnorderedList');
      break;
    default:
      exec(type);
      break;
  }
  return false;
};

const action = (type: string) => ({
  name: type,
  result: () => handleResult(type),
});

const actions = [
  action('bold'),
  action('italic'),
  action('underline'),
  action('strikethrough'),
  action('olist'),
  action('ulist'),
  {
    ...action('link'),
    icon: ReactDOMServer.renderToString(<FontAwesomeIcon icon={faLink} />),
  },
  {
    ...action('image'),
    icon: ReactDOMServer.renderToString(<FontAwesomeIcon icon={faImage} />),
  },
];

const classes = {
  button: css.button,
  selected: css.buttonSelected,
  content: `editorContent ${css.content}`,
};

export type Props = {
  id: string,
  name?: string,
  value?: any,
  required?: boolean,
  hasError?: Function,
  myRef?: any,
  dark?: boolean,
};

type PellEditor = {
  content: HTMLElement,
};

export function InputTextarea(props: Props): Node {
  const {
    id, name, value: propValue, required, hasError, myRef, dark,
  } = props;
  const [value, setValue] = useState<string>(sanitize(propValue) || '');
  const editorRef = useRef<?HTMLDivElement>(null);
  const editor = useRef<?PellEditor>(null);

  const onChange = (updatedValue: string) => {
    setValue(sanitize(updatedValue));
  };

  const onBlur = () => {
    if (required && hasError) {
      hasError(!value || value === '<p><br /></p>');
    }
  };

  const onFocus = () => {
    if (required && hasError) {
      hasError(false);
    }
    if (editorRef.current) {
      editorRef.current.getElementsByClassName('editorContent')[0].focus();
    }
  };

  const onPaste = (e: SyntheticEvent<HTMLElement>) => {
    e.preventDefault();

    const clipboardData = (e.originalEvent && e.originalEvent.clipboardData) || e.clipboardData;
    const text = clipboardData ? clipboardData.getData('text/plain') : '';

    document.execCommand('insertHTML', false, sanitize(text));
  };

  useEffect(() => {
    if (editorRef.current) {
      const currentEditorRef = editorRef.current;
      editor.current = init({
        element: currentEditorRef.getElementsByClassName('editor')[0],
        onChange,
        classes,
        actions,
      });
      if (editor.current) {
        editor.current.content.innerHTML = value;
      }
      const toolbarButtons = currentEditorRef.querySelectorAll(
        '.pell-actionbar button',
      );
      toolbarButtons.forEach((btn: HTMLElement) => {
        btn.addEventListener(
          'mousedown',
          (event: SyntheticEvent<HTMLElement>) => event.preventDefault(),
        );
        btn.addEventListener('click', () => {
          if (editor.current) {
            editor.current.content.focus({ preventScroll: true });
          }
        });
      });
      return () => {
        toolbarButtons.forEach((btn: HTMLElement) => {
          btn.removeEventListener(
            'mousedown',
            (event: SyntheticEvent<HTMLElement>) => event.preventDefault(),
          );
          btn.removeEventListener('click', () => {
            if (editor.current) {
              editor.current.content.focus({ preventScroll: true });
            }
          });
        });
      };
    }
    return undefined;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div
      id={id}
      className={`${inputCss.default} ${dark ? css.dark : ''} ${css.textarea}`}
      onBlur={onBlur}
      onFocus={onFocus}
      onPaste={onPaste}
      tabIndex={0}
      role="textbox"
      ref={editorRef}
    >
      <div className={`editor ${css.editor}`} />
      <input
        type="hidden"
        value={value}
        name={name}
        required={required}
        ref={myRef}
      />
    </div>
  );
}
