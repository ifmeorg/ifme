// @flow
import React, { useState } from 'react';
import type { Node } from 'react';
import { Utils } from 'utils';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretDown, faCaretUp } from '@fortawesome/free-solid-svg-icons';
import globalCss from 'styles/_global.scss';
import css from 'components/Input/Input.scss';

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
}: Props): Node => {
  const [open, setOpen] = useState(!!openProp);

  const displayContent = () => (
    <div
      className={`${open ? 'accordionContent' : css.accordionClose}`}
      role="region"
    >
      {Utils.renderContent(children)}
    </div>
  );

  const toggleOpen = () => {
    setOpen(!open);
  };

  const openToggle = (event: SyntheticKeyboardEvent<HTMLDivElement>) => {
    if (event.key === 'Enter') {
      setOpen(!open);
    }
  };
  const inputClassNames = () => `${dark ? css.dark : ''} ${large ? css.large : ''}`;

  return (
    <div id={`${id}_accordion`} className={inputClassNames()}>
      <div
        className={`accordion ${globalCss.gridRowSpaceBetween} ${css.accordion}`}
        onClick={toggleOpen}
        onKeyDown={openToggle}
        role="button"
        tabIndex="0"
        aria-expanded={open}
      >
        <div className={css.accordionTitle}>{Utils.renderContent(title)}</div>
        <div className={css.accordionCaret}>
          <FontAwesomeIcon icon={open ? faCaretUp : faCaretDown} />
        </div>
      </div>
      {displayContent()}
    </div>
  );
};
