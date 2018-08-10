// @flow
import React from 'react';
import { Tag } from '../Tag';
import css from './MomentCard.scss';

type MomentCardDraftProp = {
  draftText?: string,
};

export class MomentCardDraft extends React.Component<MomentCardDraftProp> {
  render() {
    return (
      <div className={css.draft}>
        <Tag label={this.props.draftText} />
      </div>
    );
  }
}
