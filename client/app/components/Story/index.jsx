// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { StoryName } from './StoryName';
import { StoryDate } from './StoryDate';
import { StoryDraft } from './StoryDraft';
import { StoryActions } from './StoryActions';
import type { Actions } from './StoryActions';
import { StoryBy } from './StoryBy';
import type { Props as StoryByProps } from './StoryBy';
import { StoryCategories } from './StoryCategories';
import { StoryMoods } from './StoryMoods';
import { StoryMedication } from './StoryMedication';
import css from './Story.scss';

export type Props = {
  name: string,
  link: string,
  date?: string,
  draft?: string,
  actions?: Actions,
  categories?: string[],
  moods?: string[],
  storyBy?: StoryByProps,
  storyType?: string,
  body?: any,
  medicationBody?: any,
};

const header = (
  condensed: boolean,
  actions: ?Actions,
  draft: ?string,
  name: string,
  link: string,
) => (
  <div className={css.header}>
    <div className={css.gridRowSpaceBetween}>
      <div className={css.headerTitle}>
        {draft && <StoryDraft draft={draft} />}
        <StoryName name={name} link={link} />
      </div>
      {condensed && actions && <StoryActions actions={actions} hasStory />}
    </div>
  </div>
);

const tags = (categories: ?(string[]), moods: ?(string[])) => (
  <div>
    {categories && <StoryCategories categories={categories} />}
    {moods && <StoryMoods moods={moods} />}
  </div>
);

const info = (
  storyBy: ?StoryByProps,
  storyType: ?string,
  actions: ?Actions,
) => {
  if (!storyBy || !storyType) return null;
  return (
    <div className={`${css.gridRowSpaceBetween} ${css.info}`}>
      <StoryBy author={storyBy.author} avatar={storyBy.avatar} />
      <div className={css.infoRight}>
        <div className={css.storyType}>{storyType}</div>
        {actions ? <StoryActions actions={actions} hasStory /> : null}
      </div>
    </div>
  );
};

const footer = (
  categories: ?(string[]),
  moods: ?(string[]),
  storyBy: ?StoryByProps,
  storyType: ?string,
  actions: ?Actions,
) => (
  <div className={css.footer}>
    {categories || moods ? tags(categories, moods) : null}
    {info(storyBy, storyType, actions)}
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
    medicationBody,
  } = props;
  const condensed = !storyBy && !storyType;
  return (
    <div className={`story ${css.story}`}>
      {header(condensed, actions, draft, name, link)}
      {date && <StoryDate date={date} />}
      {body && <div className={css.body}>{renderHTML(body)}</div>}
      {medicationBody && <StoryMedication {...medicationBody} />}
      {footer(categories, moods, storyBy, storyType, actions)}
    </div>
  );
};
