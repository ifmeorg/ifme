// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './MomentCard.scss';

type MomentCardMoodsProp = {
  mood?: Array<string>,
};

export class MomentCardMoods extends React.Component<MomentCardMoodsProp> {
  render() {
    const { mood } = this.props;

    const moodTag = mood
      ? mood.map(value => <Tag key={value} dark label={value} />)
      : '';

    return <div className={css.mood}>{moodTag}</div>;
  }
}
