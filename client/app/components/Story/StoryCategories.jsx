// @flow
import React from 'react';
import { Tag } from '../Tag';

export type Props = {
  categories: string[],
};

export const StoryCategories = (props: Props) => {
  const { categories } = props;
  return (
    <div className="storyCategories">
      {categories.map(value => (
        <Tag secondary key={value} label={value} />
      ))}
    </div>
  );
};
