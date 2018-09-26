// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import css from './Tooltip.scss';
import { Utils } from '../../utils';

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
        {typeof element === 'string' ? renderHTML(element) : element}
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
