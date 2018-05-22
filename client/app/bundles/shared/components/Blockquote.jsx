// @flow
import React from 'react';
import css from './Blockquote.scss';

type Props = {
  text?: string,
  author?: string,};

export default class Blockquote extends React.Component<Props> {
  render() {
    const { text, author } = this.props;
    const textClassNames = `${css.author} ${css.text}`;
    const authorClassNames = `${css.author}`;
    return (
      <div>
        <div className={textClassNames}>
          {text}
        </div>
        <div className={authorClassNames}>
          {author}
        </div>
      </div>
    );
  }
}
