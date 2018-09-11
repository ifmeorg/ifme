// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import css from './Tooltip.scss';

export type Props = {
  element: any,
  text: string,
  right?: boolean,
  center?: boolean,
};

const getPosition = (right: ?boolean, center: ?boolean) => {
  if (right) {
    return css.tooltipRight;
  }
  return center ? css.tooltipCenter : '';
};

export const Tooltip = (props: Props) => {
  const {
    element, text, right, center,
  } = props;
  return (
    <div className={`tooltip ${css.tooltip}`}>
      <div className="tooltipElement" aria-labelledby="tooltip">
        {typeof element === 'string' ? renderHTML(element) : element}
      </div>
      <div
        id="tooltip"
        className={`${getPosition(right, center)}`}
        role="tooltip"
      >
        {text}
      </div>
    </div>
  );
};
