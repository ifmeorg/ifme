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
  body?: any,
};

const header = (
  actions: ?Actions,
  draft: ?string,
  name: string,
  link: string,
) => (
  <div className={css.header}>
    <div className={css.headerTitle}>
      {draft && <StoryDraft draft={draft} />}
      <StoryName name={name} link={link} />
    </div>
    {actions ? <StoryActions actions={actions} hasStory /> : null}
  </div>
);

const tags = (categories: ?(string[]), moods: ?(string[])) => (
  <div className={css.tags}>
    {categories && <StoryCategories categories={categories} />}
    {moods && <StoryMoods moods={moods} />}
  </div>
);

const info = (storyType: ?string, storyBy: ?string) => (
  <div className={css.gridRowSpaceBetween}>
    {storyBy && <div className={css.storyBy}>{renderHTML(storyBy)}</div>}
    {storyType && <div className={css.storyType}>{storyType}</div>}
  </div>
);

const footer = (
  date: ?string,
  categories: ?(string[]),
  moods: ?(string[]),
  storyType: ?string,
  storyBy: ?string,
) => (
  <div className={css.footer}>
    {categories || moods ? tags(categories, moods) : null}
    {info(storyType, storyBy)}
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
    body,
  } = props;
  return (
    <div className={`story ${css.story}`}>
      {header(actions, draft, name, link)}
      {date && <StoryDate date={date} />}
      {body && <div className={css.body}>{renderHTML(body)}</div>}
      {footer(date, categories, moods, storyType, storyBy)}
    </div>
  );
};
