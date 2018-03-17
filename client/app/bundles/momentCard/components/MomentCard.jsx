// @flow
import React from 'react';
import MomentCardName from './MomentCardName';
import MomentCardDate from './MomentCardDate';
import MomentCardDraft from './MomentCardDraft';
import MomentCardSettings from './MomentCardSettings';
import MomentCardCategories from './MomentCardCategories';
import MomentCardMoods from './MomentCardMoods';
import Tag from '../../shared/components/Tag';
import css from './MomentCard.scss';

type MomentCardState = {};

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

export default class MomentCard extends React.Component {
  props: MomentCardProp;
  state: MomentCardState;

  render() {
    const { cardType, date, item, draftText,viewersText } = this.props;
    
    const category = item.category ? 
                      item.category.map((category, i) => <Tag key={i} label={category} />) 
                      : ''                      
    const mood = item.mood ? 
                  item.mood.map((mood, i) => <Tag key={i} dark label={mood} />) 
                  : ''    
                      
    return (
      <div className={css.moment}>
        <div className={css.header}>
          { cardType === 'Draft' && <MomentCardDraft draftText={draftText} /> }
          <MomentCardName name={item.name} />
          <MomentCardSettings cardType={cardType} viewersText={viewersText} />
        </div>
        <MomentCardDate date={date} />
        <div className={css.tags}>          
          <MomentCardCategories category={category} />                          
          <MomentCardMoods mood={mood} />                  
        </div>                
      </div>
    );
  }
}
