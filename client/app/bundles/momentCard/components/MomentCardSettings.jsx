// @flow
import React from 'react';
import MomentCardViewers from './MomentCardViewers';
import css from './MomentCard.scss';

type MomentCardSettingsProp = {
  action: {
    edit?: any,
    delete?: any,
    viewer?: any
  },
  cardType: string,
  viewersText?: string
};

export default class MomentCardSettings extends
  React.Component <MomentCardSettingsProp> {
  render() {
    return (
      <div className={css.settings}>
        <i onClick={this.props.action.viewer} className={`fa fa-lock ${css.action}`} />
        {
          this.props.cardType !== 'Example' &&
          <span>
            <i onClick={this.props.action.delete} className={`fa fa-trash-o ${css.action}`} />
            <i onClick={this.props.action.edit} className={`fa fa-pencil ${css.action}`} />
          </span>
        }
        <MomentCardViewers viewersText={this.props.viewersText} />
      </div>
    );
  }
}
