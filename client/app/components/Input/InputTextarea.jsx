// @flow
import React from 'react';
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
  Object.assign({}, action('link'), {
    icon: ReactDOMServer.renderToString(<FontAwesomeIcon icon={faLink} />),
  }),
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

export class InputTextarea extends React.Component<Props, State> {
  editor: any;

  editorRef: any;

  constructor(props: Props) {
    super(props);
    this.state = {
      value: props.value || '',
    };
  }

  componentDidMount() {
    const { value } = this.state;
    if (this.editorRef) {
      this.editor = init({
        element: this.editorRef.getElementsByClassName('editor')[0],
        onChange: this.onChange,
        classes,
        actions,
      });
      this.editor.content.innerHTML = value;
    }
  }

  onChange = (value: string) => {
    this.setState({ value });
  };

  onBlur = () => {
    const { required, hasError } = this.props;
    const { value } = this.state;
    if (required && hasError) {
      hasError(!value || value === '<p><br></p>');
    }
  };

  onFocus = () => {
    const { required, hasError } = this.props;
    if (required && hasError) {
      hasError(false);
    }
    if (this.editorRef) {
      this.editorRef.getElementsByClassName('editorContent')[0].focus();
    }
  };

  displayHidden = () => {
    const { name, required, myRef } = this.props;
    const { value } = this.state;
    return (
      <input
        type="hidden"
        value={value}
        name={name}
        required={required}
        ref={myRef}
      />
    );
  };

  render() {
    const { id, dark } = this.props;
    return (
      <div
        id={id}
        className={`${inputCss.default} ${dark ? css.dark : ''}`}
        onBlur={this.onBlur}
        onFocus={this.onFocus}
        tabIndex={0}
        role="textbox"
        ref={(element) => {
          this.editorRef = element;
        }}
      >
        <div className="editor" />
        {this.displayHidden()}
      </div>
    );
  }
}
