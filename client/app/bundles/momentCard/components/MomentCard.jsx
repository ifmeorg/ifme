// @flow
import React from 'react';
import MomentCardName from './MomentCardName';
import MomentCardDate from './MomentCardDate';
import MomentCardDraft from './MomentCardDraft';
import MomentCardSettings from './MomentCardSettings';
import MomentCardCategories from './MomentCardCategories';
import MomentCardMoods from './MomentCardMoods';
import css from './MomentCard.scss';

type MomentCardProp = {
  item: {
    name: string,
    category?: Array<string>,
    mood?: Array<string>,
  },
  date: string,
  cardType: string,
  draftText?: string,
  viewersText?: string
};

export default class MomentCard extends React.Component <MomentCardProp> {
  render() {
    const { cardType, date, item, draftText, viewersText } = this.props;

    return (
      <div className={css.moment}>
        <div className={css.header}>
          { cardType === 'Draft' && <MomentCardDraft draftText={draftText} /> }
          <MomentCardName name={item.name} />
          <MomentCardSettings cardType={cardType} viewersText={viewersText} />
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
