// @flow
import React, { useState, useEffect } from 'react';
import ReactDOMServer from 'react-dom/server';
import { init, exec } from 'pell';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faLink } from '@fortawesome/free-solid-svg-icons';
import css from './InputTextarea.scss';
import inputCss from './Input.scss';

// TODO (julianguyen): Tests after writing stubs for pell editor

const handleResult = (type: string) => {
  switch (type) {
    case 'link': {
      const url = window.prompt('URL');
      if (url) exec('createLink', url);
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

export type State = {
  value?: any,
};

export function InputTextarea({
  id,
  name,
  value,
  required,
  hasError,
  myRef,
  dark,
}: Props) {
  const [currentValue, setValue] = useState<State>(value || '');
  let editorRef;
  let editor;

  const onChange = (updatedValue: string) => {
    setValue(updatedValue);
  };

  const onBlur = () => {
    if (required && hasError) {
      hasError(!currentValue || currentValue === '<p><br></p>');
    }
  };

  const onFocus = () => {
    if (required && hasError) {
      hasError(false);
    }
    if (editorRef) {
      editorRef.getElementsByClassName('editorContent')[0].focus();
    }
  };

  const displayHidden = () => (
    <input
      type="hidden"
      value={currentValue}
      name={name}
      required={required}
      ref={myRef}
    />
  );

  useEffect(() => {
    if (editorRef) {
      editor = init({
        element: editorRef.getElementsByClassName('editor')[0],
        onChange,
        classes,
        actions,
      });
      editor.content.innerHTML = currentValue;
    }
  });

  return (
    <div
      id={id}
      className={`${inputCss.default} ${dark ? css.dark : ''}`}
      onBlur={onBlur}
      onFocus={onFocus}
      tabIndex={0}
      role="textbox"
      ref={(element) => {
        editorRef = element;
      }}
    >
      <div className={`editor ${css.editor}`} />
      {displayHidden()}
    </div>
  );
}

