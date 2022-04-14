// @flow
import React from 'react';
import type { Node } from 'react';
import { Tag } from 'components/Tag';
import css from './Story.scss';

export type Mood = {
  name: string,
  slug: string,
};

export type Props = {
  moods: Mood[],
};

export const StoryMoods = (props: Props): Node => {
  const { moods } = props;
  return (
    <div className={`storyMoods ${css.moods}`}>
      {moods.map((value) => (
        <Tag key={value.name} dark label={value.name} href={value.slug} />
      ))}
    </div>
  );
};
