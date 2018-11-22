// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faAsterisk, faQuestion } from '@fortawesome/free-solid-svg-icons';
import { Tooltip } from '../Tooltip';
import css from './Input.scss';
import globalCss from '../../styles/_global.scss';

export type Props = {
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

const displayLabel = (label: string, error: ?boolean) => (
  <div className={`${error ? css.error : ''} ${css.labelText}`}>{label}</div>
);

export const InputLabel = (props: Props) => {
  const {
    error, label, required, info,
  } = props;
  return (
    <div className={`${globalCss.gridRowSpaceBetween} ${css.label}`}>
      <div className={css.labelInfo}>{displayLabel(label, error)}</div>
      {required || info ? displayTags(required, info) : null}
    </div>
  );
};
