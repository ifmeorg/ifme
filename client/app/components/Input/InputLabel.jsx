// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faAsterisk,
  faQuestion,
  faExclamation,
} from '@fortawesome/free-solid-svg-icons';
import { Tooltip } from '../Tooltip';
import css from './Input.scss';
import globalCss from '../../styles/_global.scss';

export type Props = {
  id: string,
  label: string,
  required?: boolean,
  info?: string,
  error?: boolean,
};

const displayTags = (required: ?boolean, info: ?string) => (
  <div className={css.tags}>
    {info ? (
      <div>
        <Tooltip
          element={<FontAwesomeIcon icon={faQuestion} />}
          text={info}
          right
        />
      </div>
    ) : null}
    {required ? (
      <div>
        <FontAwesomeIcon icon={faAsterisk} />
      </div>
    ) : null}
  </div>
);

const displayLabel = (id: string, label: string, error: ?string) => {
  return (
    <label htmlFor={id} className={error ? css.error : ''}>
      {label}
    </label>
  );
};

export const InputLabel = (props: Props) => {
  const {
    error, label, required, info, id,
  } = props;
  return (
    <div className={`${globalCss.gridRowSpaceBetween} ${css.label}`}>
      <div className={css.labelInfo}>
        {displayLabel(id, label, error)}
        {error ? <FontAwesomeIcon icon={faExclamation} /> : null}
      </div>
      {required || info ? displayTags(required, info) : null}
    </div>
  );
};
