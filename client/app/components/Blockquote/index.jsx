// @flow
import React from 'react';
import css from './Blockquote.scss';

export interface Props {
  text?: string;
  author?: string;
}

export const Blockquote = (props: Props) => {
  const { text, author } = props;
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
};
