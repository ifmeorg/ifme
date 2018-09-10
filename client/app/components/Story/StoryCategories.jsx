// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './Story.scss';

export interface Props {
  categories: string[];
}

export const StoryCategories = (props: Props) => {
  const { categories } = props;
  return (
    <div className={css.category}>
      {categories.map(value => <Tag key={value} label={value} />)}
    </div>
  );
};
