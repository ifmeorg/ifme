// @flow
import React from 'react';
import css from './Story.scss';

export type Props = {
  name: string,
  link: ?string,
};

export const StoryName = (props: Props) => {
  const { name, link } = props;
  if (link) {
    return (
      <a className={css.name} href={link}>
        {name}
      </a>
    );
  }
  return (
    <span className={css.name}>
      {name}
    </span>
  );
};
