// @flow
import React, { useState } from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretDown, faCaretUp } from '@fortawesome/free-solid-svg-icons';
import globalCss from '../../styles/_global.scss';
import css from '../Input/Input.scss';

export type Props = {
  id: string,
  children: any,
  title: any,
  dark?: boolean,
  large?: boolean,
  open?: boolean,
};

export type State = {
  open: boolean,
};

export const Accordion = ({
  id,
  children,
  title,
  dark,
  large,
  open: openProp,
}: Props) => {
  const [open, setOpen] = useState(!!openProp);

  const displayContent = () => (
    <div className={`${open ? 'accordionContent' : css.accordionClose}`}>
      {typeof children === 'string' ? renderHTML(children) : children}
    </div>
  );

  const toggleOpen = () => {
    setOpen(!open);
  };

  const inputClassNames = () => `${dark ? css.dark : ''} ${large ? css.large : ''}`;

  return (
    <div id={`${id}_accordion`} className={inputClassNames()}>
      <div
        className={`accordion ${globalCss.gridRowSpaceBetween} ${css.accordion}`}
        onClick={toggleOpen}
        onKeyDown={toggleOpen}
        role="button"
        tabIndex="0"
        aria-expanded={open}
      >
        <div className={css.accordionTitle}>
          {typeof title === 'string' ? renderHTML(title) : title}
        </div>
        <div className={css.accordionCaret}>
          <FontAwesomeIcon icon={open ? faCaretUp : faCaretDown} />
        </div>
      </div>
      {displayContent()}
    </div>
  );
};
