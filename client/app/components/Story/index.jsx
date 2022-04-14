// @flow
import React, { type Element, type Node } from 'react';
import { Utils } from 'utils';
import { StoryName } from 'components/Story/StoryName';
import { StoryDate } from 'components/Story/StoryDate';
import { StoryDraft } from 'components/Story/StoryDraft';
import { StoryActions } from 'components/Story/StoryActions';
import type { Actions } from 'components/Story/StoryActions';
import { StoryBy } from 'components/Story/StoryBy';
import type { Props as StoryByProps } from 'components/Story/StoryBy';
import { StoryCategories } from 'components/Story/StoryCategories';
import type { Category } from 'components/Story/StoryCategories';
import { StoryMoods } from 'components/Story/StoryMoods';
import type { Mood } from 'components/Story/StoryMoods';
import { StoryMedication } from 'components/Story/StoryMedication';
import type { Props as Medication } from 'components/Story/StoryMedication';
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
  body?: string | Element<any> | any,
  medicationBody?: Medication,
  onClick?: Function,
};

const renderHeader = (
  condensed: boolean,
  actions: ?Actions,
  draft: ?string,
  name: string,
  link: ?string,
  onClick: ?Function,
) => (
  <div className={css.header}>
    <div className={css.gridRowSpaceBetween}>
      <div className={css.headerTitle}>
        {draft && <StoryDraft draft={draft} />}
        <StoryName name={name} link={link} onClick={onClick} />
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
  onClick,
}: Props): Node => {
  const condensed = !storyBy && !storyType;
  return (
    <div className={`story ${css.story}`}>
      {renderHeader(condensed, actions, draft, name, link, onClick)}
      {date && <StoryDate date={date} />}
      {body && <div className={css.body}>{Utils.renderContent(body)}</div>}
      {medicationBody && renderMedicationBody(medicationBody)}
      {renderFooter(categories, moods, storyBy, storyType, actions)}
    </div>
  );
};
