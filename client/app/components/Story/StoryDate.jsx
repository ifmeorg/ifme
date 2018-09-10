// @flow
import React from 'react';
import css from './Story.scss';

export interface Props {
  date: string;
}

export const StoryDate = (props: Props) => (
  <div className={css.date}>{props.date}</div>
);
