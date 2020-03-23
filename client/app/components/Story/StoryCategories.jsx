// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './Story.scss';

export type Category = {
  name: string,
  slug: string,
};

export type Props = {
  categories: Category[],
};

export const StoryCategories = (props: Props) => {
  const { categories } = props;
  return (
    <div className={`storyCategories ${css.categories}`}>
      {categories.map((value) => (
        <Tag secondary key={value.name} label={value.name} href={value.slug} />
      ))}
    </div>
  );
};
