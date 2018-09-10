// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './Story.scss';

export interface Props {
  draft: string;
}

export const StoryDraft = (props: Props) => (
  <div className={css.draft}>
    <Tag label={props.draft} />
  </div>
);
