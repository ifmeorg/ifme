// @flow
import React from 'react';
import type { Node } from 'react';
import { Tag } from 'components/Tag';
import css from './Story.scss';

export type Category = {
  name: string,
  slug: string,
};

export type Props = {
  categories: Category[],
};

export const StoryCategories = (props: Props): Node => {
  const { categories } = props;
  return (
    <div className={`storyCategories ${css.categories}`}>
      {categories.map((value) => (
        <Tag secondary key={value.name} label={value.name} href={value.slug} />
      ))}
    </div>
  );
};
