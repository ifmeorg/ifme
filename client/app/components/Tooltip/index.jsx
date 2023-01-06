// @flow
import React from 'react';
import type { Node } from 'react';
import { Utils } from 'utils';
import css from './Tooltip.scss';

export type Props = {
  element: any,
  text: string,
  right?: boolean,
  center?: boolean,
  id?: string,
};

const getPosition = (right: ?boolean, center: ?boolean) => {
  if (right) {
    return css.tooltipRight;
  }
  return center ? css.tooltipCenter : '';
};

export const Tooltip = (props: Props): Node => {
  const {
    element, text, right, center, id,
  } = props;
  const tooltipId = id || `tooltip${Utils.randomString()}`;
  return (
    <div className={css.tooltipWrapper}>
      <div className={css.tooltipElement} aria-labelledby={tooltipId}>
        {Utils.renderContent(element)}
      </div>
      <div
        id={tooltipId}
        role="tooltip"
        className={`${css.tooltip} ${getPosition(right, center)}`}
      >
        {text}
      </div>
    </div>
  );
};
