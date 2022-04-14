// @flow
import React from 'react';
import type { Node } from 'react';
import { Tag } from 'components/Tag';
import css from './Story.scss';

export type Props = {
  draft: string,
};

export const StoryDraft = (props: Props): Node => {
  const { draft } = props;
  return (
    <div className={`storyDraft ${css.draft}`}>
      <Tag label={draft} />
    </div>
  );
};
