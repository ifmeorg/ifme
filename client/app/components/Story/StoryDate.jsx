// @flow
import React from 'react';
import css from './Story.scss';

export type Props = {
  date: string,
};

export const StoryDate = (props: Props) => {
  const { date } = props;
  return <div className={css.date}>{date}</div>;
};
