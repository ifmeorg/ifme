// @flow
import React from 'react';
import Tag from '../../shared/components/Tag';
import css from './MomentCard.scss';

type MomentCardMoodsProp = {
  mood?: Array<string>
};

export default class MomentCardMoods
  extends React.Component <MomentCardMoodsProp> {
  render() {
    const { mood } = this.props;

    const moodTag = mood ?
      mood.map(value => <Tag key={value} dark label={value} />)
      : '';

    return (
      <div className={css.mood}>
        {moodTag}
      </div>
    );
  }
}
