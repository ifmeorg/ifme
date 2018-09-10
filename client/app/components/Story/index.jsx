// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { StoryName } from './StoryName';
import { StoryDate } from './StoryDate';
import { StoryDraft } from './StoryDraft';
import { StoryActions } from './StoryActions';
import { StoryCategories } from './StoryCategories';
import { StoryMoods } from './StoryMoods';
import css from './Story.scss';

export interface Props {
  name: string;
  link: string;
  date?: string;
  draft?: string;
  actions?: {
    edit?: string,
    delete?: string,
    viewers?: string,
  };
  categories?: string[];
  moods?: string[];
  storyBy?: string;
  storyType?: string;
}

const header = (props: Props) => {
  const { actions, draft, name, link } = props;
  return (
    <div className={css.header}>
      <div className={css.headerTitle}>
        {draft ? <StoryDraft draft={draft} /> : null}
        <StoryName name={name} link={link} />
      </div>
      {actions ? <StoryActions actions={actions} link={link} /> : null}
    </div>
  );
};

const tags = (props: Props) => {
  const { categories, moods } = props;
  return (
    <div className={css.tags}>
      {categories ? <StoryCategories categories={categories} /> : null}
      {moods ? <StoryMoods moods={moods} /> : null}
    </div>
  );
};

const info = (props: Props) => {
  const { storyType, storyBy } = props;
  return (
    <div className={css.gridRowSpaceBetween}>
      {storyBy ? (
        <div className={css.storyBy}>{renderHTML(storyBy)}</div>
      ) : null}
      {storyType ? <div className={css.storyType}>{storyType}</div> : null}
    </div>
  );
};

export const Story = (props: Props) => {
  const { date, categories, moods } = props;
  return (
    <div className={css.story}>
      {header(props)}
      {date ? <StoryDate date={date} /> : null}
      {categories || moods ? tags(props) : null}
      {info(props)}
    </div>
  );
};
