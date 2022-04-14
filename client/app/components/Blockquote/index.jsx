// @flow
import React from 'react';
import type { Node } from 'react';
import css from './Blockquote.scss';

export type Props = {
  text?: string,
  author?: string,
};

export const Blockquote = (props: Props): Node => {
  const { text, author } = props;
  const textClassNames = `${css.text}`;
  const authorClassNames = `${css.author}`;
  return (
    <blockquote className={textClassNames}>
      <p>
        <q>{text}</q>
      </p>
      <div className={authorClassNames}>{author}</div>
    </blockquote>
  );
};
