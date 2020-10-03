// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faExclamation } from '@fortawesome/free-solid-svg-icons';
import { I18n } from 'libs/i18n';
import css from './Input.scss';

export type Props = {
  error?: boolean,
};

export const InputError = (props: Props) => {
  const { error } = props;
  if (!error) return null;
  return (
    <div className={`labelError ${css.label} ${css.labelError}`} role="alert">
      <FontAwesomeIcon icon={faExclamation} />
      &emsp;
      {I18n.t('common.form.empty_error')}
    </div>
  );
};
