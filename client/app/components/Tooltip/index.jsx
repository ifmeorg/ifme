// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import css from './Tooltip.scss';

export interface Props {
  element: any;
  text: string;
  right?: boolean;
}

export const Tooltip = (props: Props) => {
  const { element, text, right } = props;
  return (
    <div className={css.tooltip}>
      <div className="tooltipElement">
        {typeof element === 'string' ? renderHTML(element) : element}
      </div>
      <div className={`${right ? css.tooltipRight : null}`}>
        {text}
      </div>
    </div>
  );
};
