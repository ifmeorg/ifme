// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './Story.scss';

export interface Props {
  moods: string[];
}

export const StoryMoods = (props: Props) => {
  const { moods } = props;
  return (
    <div className={css.mood}>
      {moods.map(value => <Tag key={value} dark label={value} />)}
    </div>
  );
};
