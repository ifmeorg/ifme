// @flow
import React from 'react';
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

export const Tooltip = (props: Props) => {
  const {
    element, text, right, center, id,
  } = props;
  const tooltipId = id || `tooltip${Utils.randomString()}`;
  return (
    <div className={`tooltip ${css.tooltip}`}>
      <div className="tooltipElement" aria-labelledby={tooltipId}>
        {Utils.renderContent(element)}
      </div>
      <div
        id={tooltipId}
        className={`${getPosition(right, center)}`}
        role="tooltip"
      >
        {text}
      </div>
    </div>
  );
};
