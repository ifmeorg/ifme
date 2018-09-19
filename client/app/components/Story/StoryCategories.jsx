// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './Story.scss';

export type Props = {
  categories: string[],
};

export const StoryCategories = (props: Props) => {
  const { categories } = props;
  return (
    <div className={`storyCategories ${css.categories}`}>
      {categories.map(value => (
        <Tag secondary key={value} label={value} />
      ))}
    </div>
  );
};
