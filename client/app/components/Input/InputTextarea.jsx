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
  myRef?: any,
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
    const contentValue = stateToHTML(editorState.getCurrentContent());
    if (value !== contentValue) {
      if (required && hasError) {
        hasError(!contentValue);
      }
      this.setState({ editorState, value: contentValue });
    }
    this.setState({ editorState });
  };

  onBlur = () => {
    const { required, hasError } = this.props;
    const { value } = this.state;
    if (required && hasError) {
      hasError(!value);
    }
  };

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
  };

  getContentValue = () => {
    const { editorState, value } = this.state;
    return value && value.length
      ? stateToHTML(editorState.getCurrentContent())
      : '';
  };

  render() {
    const {
      id, name, required, myRef,
    } = this.props;
    return (
      <div id={id} className={inputCss.default}>
        {this.displayEditor()}
        <input
          type="hidden"
          value={this.getContentValue()}
          id={`${id}_value`}
          name={name}
          required={required}
          ref={myRef}
        />
      </div>
    );
  }
}
