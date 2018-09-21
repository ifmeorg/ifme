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

const contentId = (id: string) => `${id}_content`;

const editorId = (id: string) => `${id}_editor`;

const classes = (id: string) => ({
  button: css.button,
  selected: css.buttonSelected,
  content: `editorContent ${contentId(id)} ${css.content}`,
});

export type Props = {
  id: string,
  name?: string,
  value?: any,
  required?: boolean,
  hasError?: Function,
  myRef?: any,
};

export type State = {
  value?: any,
};

export class InputTextarea extends React.Component<Props, State> {
  editor: any;

  constructor(props: Props) {
    super(props);
    this.state = {
      value: props.value || '',
    };
  }

  componentDidMount() {
    const { id } = this.props;
    const { value } = this.state;
    this.editor = init({
      element: document.getElementById(editorId(id)),
      onChange: this.onChange,
      classes: classes(id),
      actions,
    });
    this.editor.content.innerHTML = value;
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
    const { required, hasError, id } = this.props;
    if (required && hasError) {
      hasError(false);
    }
    document.getElementsByClassName(contentId(id))[0].focus();
  };

  displayEditor = () => {
    const { id } = this.props;
    return <div id={editorId(id)} />;
  };

  render() {
    const {
      id, name, required, myRef,
    } = this.props;
    const { value } = this.state;
    return (
      <div
        id={id}
        className={inputCss.default}
        onBlur={this.onBlur}
        onFocus={this.onFocus}
        tabIndex={0}
        role="textbox"
      >
        {this.displayEditor()}
        <input
          type="hidden"
          value={value}
          id={`${id}_value`}
          name={name}
          required={required}
          ref={myRef}
        />
      </div>
    );
  }
}
