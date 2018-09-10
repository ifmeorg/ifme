// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import css from './Tooltip.scss';

export interface Props {
  element: any;
  text: string;
  right?: boolean;
  center?: boolean;
}

const getPosition = (props: Props) => {
  const { right, center } = props;
  if (right) {
    return css.tooltipRight;
  }
  return center ? css.tooltipCenter : '';
};

export const Tooltip = (props: Props) => {
  const { element, text } = props;
  return (
    <div className={`tooltip ${css.tooltip}`}>
      <div className="tooltipElement" aria-labelledby="tooltip">
        {typeof element === 'string' ? renderHTML(element) : element}
      </div>
      <div id="tooltip" className={`${getPosition(props)}`} role="tooltip">
        {text}
      </div>
    </div>
  );
};
