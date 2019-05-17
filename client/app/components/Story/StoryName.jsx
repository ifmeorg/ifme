// @flow
import React from 'react';
import css from './Story.scss';

export type Props = {
  name: string,
};

export const StoryName = (props: Props) => {
  const { name } = props;
  return (
    <span className={css.name}>
      {name}
    </span>
  );
};
