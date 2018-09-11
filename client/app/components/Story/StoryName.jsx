// @flow
import React from 'react';
import css from './Story.scss';

export type Props = {
  name: string,
  link: string,
};

export const StoryName = (props: Props) => {
  const { link, name } = props;
  return (
    <a className={css.name} href={link}>
      {name}
    </a>
  );
};
