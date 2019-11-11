// @flow
import React from 'react';
import css from './LoadMoreButton.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  onClick?: () => void,
};
export class LoadMoreButton extends React.Component<Props> {
  render() {
    const { onClick } = this.props;
    return (
      <center>
        <button
          type="button"
          className={`loadMore ${css.buttonDarkM}`}
          onClick={onClick}
        >
          {I18n.t('load_more')}
        </button>
      </center>
    );
  }
}
