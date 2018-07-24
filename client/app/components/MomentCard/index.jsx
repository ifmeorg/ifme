// @flow
import React from 'react';
import { MomentCardName } from './MomentCardName';
import { MomentCardDate } from './MomentCardDate';
import { MomentCardDraft } from './MomentCardDraft';
import { MomentCardSettings } from './MomentCardSettings';
import { MomentCardCategories } from './MomentCardCategories';
import { MomentCardMoods } from './MomentCardMoods';
import css from './MomentCard.scss';

type MomentCardProp = {
  action: {
    edit?: any,
    delete?: any,
    viewer?: any,
  },
  item: {
    name: string,
    category?: Array<string>,
    mood?: Array<string>,
  },
  date: string,
  cardType?: string,
  draftText?: string,
};

export class MomentCard extends React.Component<MomentCardProp> {
  render() {
    const { action, cardType = 'Normal', date, item, draftText } = this.props;

    return (
      <div className={css.moment}>
        <div className={css.header}>
          <MomentCardSettings action={action} />
          {cardType === 'Draft' && <MomentCardDraft draftText={draftText} />}
          <MomentCardName name={item.name} />
        </div>
        <MomentCardDate date={date} />
        <div className={css.tags}>
          <MomentCardCategories category={item.category} />
          <MomentCardMoods mood={item.mood} />
        </div>
      </div>
    );
  }
}
