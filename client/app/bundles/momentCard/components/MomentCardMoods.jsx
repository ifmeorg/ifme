// @flow
import React from 'react';
import css from './MomentCard.scss';

type MomentCardMoodsState = {};

type MomentCardMoodsProp = {
  mood: any
};

export default class MomentCardMoods
  extends React.Component {
  props: MomentCardMoodsProp;
  state: MomentCardMoodsState;

  render() {
    const { mood } = this.props;
    
    return (
      <div className={css.mood}>
        {mood}
      </div>
    );
  }
}
