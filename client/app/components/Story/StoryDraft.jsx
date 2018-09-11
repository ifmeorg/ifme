// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './Story.scss';

export type Props = {
  draft: string,
};

export const StoryDraft = (props: Props) => {
  const { draft } = props;
  return (
    <div className={css.draft}>
      <Tag label={draft} />
    </div>
  );
};
