// @flow
import React from 'react';
import { I18n } from 'libs/i18n';
import css from './LoadMoreButton.scss';

export type Props = {
  onClick?: () => void,
};

const LoadMoreButton = ({ onClick }: Props) => (
  <div className={css.container}>
    <button
      type="button"
      className={`loadMore ${css.buttonDarkM}`}
      onClick={onClick}
    >
      {I18n.t('load_more')}
    </button>
  </div>
);

export { LoadMoreButton };
