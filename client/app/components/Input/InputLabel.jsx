// @flow
import React from 'react';
import type { Node } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faAsterisk, faQuestion } from '@fortawesome/free-solid-svg-icons';
import globalCss from 'styles/_global.scss';
import { Tooltip } from 'components/Tooltip';
import css from './Input.scss';

export type Props = {
  label: string,
  required?: boolean,
  info?: string,
  error?: boolean,
  htmlFor: string,
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

export const InputLabel = (props: Props): Node => {
  const {
    error, label, required, info, htmlFor,
  } = props;
  return (
    <label
      htmlFor={htmlFor}
      className={`${globalCss.gridRowSpaceBetween} ${css.label}`}
    >
      <div className={css.labelInfo}>{displayLabel(label, error)}</div>
      {required || info ? displayTags(required, info) : null}
    </label>
  );
};
