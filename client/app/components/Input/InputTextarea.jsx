// @flow
import React from 'react';
import { Editor } from 'react-draft-wysiwyg';
import { stateToHTML } from 'draft-js-export-html';
import { stateFromHTML } from 'draft-js-import-html';
// $FlowFixMe
import { EditorState } from 'draft-js';
import css from './InputTextarea.scss';
import inputCss from './Input.scss';

// TODO (julianguyen): Write tests for this, mocking draft-js is hard
// https://github.com/facebook/draft-js/issues/325

export type Props = {
  id: string,
  name?: string,
  value?: any,
  required?: boolean,
  hasError?: Function,
};

export type State = {
  editorState: any,
  value?: any,
};

export class InputTextarea extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      value: props.value || '',
      editorState: EditorState.createWithContent(
        stateFromHTML(props.value || ''),
      ),
    };
  }

  onEditorStateChange = (editorState: any) => {
    const { required, hasError } = this.props;
    const { value } = this.state;
    const contentValueHTML = stateToHTML(editorState.getCurrentContent());
    const contentValue = contentValueHTML === '<p><br></p>' ? '' : contentValueHTML;
    if (value !== contentValue) {
      if (required && hasError) {
        hasError(!contentValue);
      }
      this.setState({ editorState, value: contentValue });
    }
  }

  onBlur = () => {
    const { required, hasError } = this.props;
    const { value } = this.state;
    if (required && hasError) {
      hasError(!value);
    }
  }

  displayEditor = () => {
    const { editorState } = this.state;
    return (
      <Editor
        toolbarClassName={css.toolbar}
        toolbar={{
          options: ['inline', 'list'],
          inline: {
            className: css.toolbarIcons,
            inDropdown: false,
            options: ['bold', 'italic', 'underline', 'strikethrough'],
          },
          list: {
            className: css.toolbarIcons,
            inDropdown: false,
            options: ['unordered', 'ordered'],
          },
        }}
        editorState={editorState}
        onEditorStateChange={this.onEditorStateChange}
        onBlur={this.onBlur}
      />
    );
  }

  render() {
    const { id, name, required } = this.props;
    const { editorState, value } = this.state;
    const contentValue = value && value.length ? stateToHTML(editorState.getCurrentContent()) : '';
    return (
      <div className={inputCss.default}>
        {this.displayEditor()}
        <input
          type="hidden"
          value={contentValue}
          id={id}
          name={name}
          required={required}
        />
      </div>
    );
  }
}
