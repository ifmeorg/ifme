// @flow
import React from 'react';
import css from './Blockquote.scss';

type Props = {
  text?: string,
  author?: string,
};

export class Blockquote extends React.Component<Props> {
  render() {
    const { text, author } = this.props;
    const textClassNames = `${css.text}`;
    const authorClassNames = `${css.author}`;
    return (
      <div className={textClassNames}>
        <p>
          <q>{text}</q>
        </p>
        <div className={authorClassNames}>{author}</div>
      </div>
    );
  }
}
