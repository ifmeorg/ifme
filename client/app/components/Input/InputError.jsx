// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faExclamation } from '@fortawesome/free-solid-svg-icons';
import css from './Input.scss';
import globalCss from '../../styles/_global.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  error?: boolean,
};

export const InputError = (props: Props) => {
  const { error } = props;
  return (
    <div className={css.labelInfo}>
      {error ? (
        <div className={`labelError ${globalCss.smallMarginTop} ${css.label}`}>
          <FontAwesomeIcon icon={faExclamation} />
          &emsp;
          {I18n.t('common.form.error_explanation')}
        </div>
      ) : null}
    </div>
  );
};
