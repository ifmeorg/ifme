// @flow
import React from 'react';
import MomentCardViewers from './MomentCardViewers';
import css from './MomentCard.scss';

type MomentCardSettingsProp = {
  cardType: string,
  viewersText?: string
};

export default class MomentCardSettings extends
  React.Component <MomentCardSettingsProp> {
  render() {
    return (
      <div className={css.settings}>
        <i className={`fa fa-lock ${css.action}`} />
        {
          this.props.cardType !== 'Example' &&
          <span>
            <i className={`fa fa-trash-o ${css.action}`} />
            <i className={`fa fa-pencil ${css.action}`} />
          </span>
        }
        <MomentCardViewers viewersText={this.props.viewersText} />
      </div>
    );
  }
}
