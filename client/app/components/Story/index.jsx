// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { StoryName } from './StoryName';
import { StoryDate } from './StoryDate';
import { StoryDraft } from './StoryDraft';
import { StoryActions } from './StoryActions';
import type { Actions } from './StoryActions';
import { StoryCategories } from './StoryCategories';
import { StoryMoods } from './StoryMoods';
import css from './Story.scss';

export type Props = {
  name: string,
  link: string,
  date?: string,
  draft?: string,
  actions?: Actions,
  categories?: string[],
  moods?: string[],
  storyBy?: string,
  storyType?: string,
};

const header = (
  actions: ?Actions,
  draft: ?string,
  name: string,
  link: string,
) => (
  <div className={css.header}>
    <div className={css.headerTitle}>
      {draft ? <StoryDraft draft={draft} /> : null}
      <StoryName name={name} link={link} />
    </div>
    {actions ? <StoryActions actions={actions} link={link} /> : null}
  </div>
);

const tags = (categories: ?(string[]), moods: ?(string[])) => (
  <div className={css.tags}>
    {categories ? <StoryCategories categories={categories} /> : null}
    {moods ? <StoryMoods moods={moods} /> : null}
  </div>
);

const info = (storyType: ?string, storyBy: ?string) => (
  <div className={css.gridRowSpaceBetween}>
    {storyBy ? <div className={css.storyBy}>{renderHTML(storyBy)}</div> : null}
    {storyType ? <div className={css.storyType}>{storyType}</div> : null}
  </div>
);

export const Story = (props: Props) => {
  const {
    date,
    categories,
    moods,
    storyType,
    storyBy,
    actions,
    draft,
    name,
    link,
  } = props;
  return (
    <div className={css.story}>
      {header(actions, draft, name, link)}
      {date ? <StoryDate date={date} /> : null}
      {categories || moods ? tags(categories, moods) : null}
      {info(storyType, storyBy)}
    </div>
  );
};
