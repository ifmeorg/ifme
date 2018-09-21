// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import css from './Story.scss';
import { Avatar } from '../Avatar';

export type Props = {
  avatar?: string,
  author: any,
};

export const StoryBy = (props: Props) => {
  const { avatar, author } = props;
  return (
    <div className={css.storyBy}>
      <Avatar src={avatar} small />
      <div className={css.storyByAuthor}>
        {typeof author === 'string' ? renderHTML(author) : author}
      </div>
    </div>
  );
};
