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
import type { Category } from './StoryCategories';
import { StoryMoods } from './StoryMoods';
import type { Mood } from './StoryMoods';
import { StoryMedication } from './StoryMedication';
import type { Props as Medication } from './StoryMedication';
import css from './Story.scss';

export type Props = {
  name: string,
  link?: string,
  date?: string,
  draft?: string,
  actions?: Actions,
  categories?: Category[],
  moods?: Mood[],
  storyBy?: StoryByProps,
  storyType?: string,
  body?: string,
  medicationBody?: Medication,
};

const renderHeader = (
  condensed: boolean,
  actions: ?Actions,
  draft: ?string,
  name: string,
  link: ?string,
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

const renderInfo = (
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
        {actions && <StoryActions actions={actions} hasStory />}
      </div>
    </div>
  );
};

const renderMedicationBody = ({
  medicationStrength,
  quantity,
  totalUnits,
  medicationDosages,
  dosageUnit,
  refill,
  medicationRefill,
}: Medication) => (
  <StoryMedication
    medicationStrength={medicationStrength}
    quantity={quantity}
    totalUnits={totalUnits}
    medicationDosages={medicationDosages}
    dosageUnit={dosageUnit}
    refill={refill}
    medicationRefill={medicationRefill}
  />
);

const renderFooter = (
  categories: ?(Category[]),
  moods: ?(Mood[]),
  storyBy: ?StoryByProps,
  storyType: ?string,
  actions: ?Actions,
) => (
  <div className={css.footer}>
    {categories && <StoryCategories categories={categories} />}
    {moods && <StoryMoods moods={moods} />}
    {renderInfo(storyBy, storyType, actions)}
  </div>
);

export const Story = ({
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
}: Props) => {
  const condensed = !storyBy && !storyType;
  return (
    <div className={`story ${css.story}`}>
      {renderHeader(condensed, actions, draft, name, link)}
      {date && <StoryDate date={date} />}
      {body && <div className={css.body}>{renderHTML(body)}</div>}
      {medicationBody && renderMedicationBody(medicationBody)}
      {renderFooter(categories, moods, storyBy, storyType, actions)}
    </div>
  );
};
