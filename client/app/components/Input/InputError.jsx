// @flow
import React from 'react';
import type { Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faExclamation } from '@fortawesome/free-solid-svg-icons';
import { I18n } from 'libs/i18n';
import css from './Input.scss';

export type Props = {
  error?: boolean,
  min?: number,
  max?: number,
};

export const InputError = (props: Props): Node => {
  const { error, min, max } = props;
  if (!error) return null;

  const getError = () => {
    if (typeof min === 'number' && typeof max === 'number') {
      return I18n.t('common.form.min_max_error', {
        min: min.toString(),
        max: max.toString(),
      });
    }
    if (typeof min === 'number') {
      return I18n.t('common.form.min_error', { min: min.toString() });
    }
    if (typeof max === 'number') {
      return I18n.t('common.form.max_error', { max: max.toString() });
    }
    return I18n.t('common.form.empty_error');
  };

  return (
    <div className={`labelError ${css.label} ${css.labelError}`} role="alert">
      <FontAwesomeIcon icon={faExclamation} />
      &emsp;
      {getError()}
    </div>
  );
};
