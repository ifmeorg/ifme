// @flow
import React, { useState } from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes } from '@fortawesome/free-solid-svg-icons';
import css from './Modal.scss';
import { I18n } from '../../libs/i18n';
import { Avatar } from '../Avatar';

export type Props = {
  element?: any,
  elementId?: string,
  body: any,
  title?: string,
  openListener?: Function,
  open?: boolean,
};

export type State = {
  open: boolean,
  modalHasFocus: boolean,
};

const Modal = (props: Props) => {
  const {
    element,
    elementId,
    body,
    title,
    openListener,
    open: openProps,
  } = props;

  const [open, setOpen] = useState(!!openProps);
  const [modalHasFocus, setModalHasFocus] = useState(true);

  const displayContent = (content: any) => {
    if (typeof content === 'string') {
      return renderHTML(content);
    }
    return content;
  };

  const toggleOpen = () => {
    const documentBody = ((document.body: any): HTMLBodyElement);
    if (!open) {
      documentBody.classList.add('bodyModalOpen');
    } else {
      documentBody.classList.remove('bodyModalOpen');
    }
    if (!open && openListener) {
      openListener();
    }
    setOpen(!open);
  };

  const displayModalHeader = () => (
    <div className={css.modalBoxHeader}>
      {title && (
        <div
          id="modalTitle"
          className={css.modalBoxHeaderTitle}
          aria-label={title}
        >
          {title}
        </div>
      )}
      <div
        className={`modalClose ${css.modalBoxHeaderClose}`}
        onClick={toggleOpen}
        onKeyDown={toggleOpen}
        role="button"
        tabIndex={0}
        aria-label={I18n.t('close')}
      >
        <FontAwesomeIcon icon={faTimes} color="#6D0839" />
      </div>
    </div>
  );

  const displayModalBody = () => (
    <div id="modalDesc" className={css.modalBoxBody}>
      {displayContent(body)}
    </div>
  );

  const handleKeyPress = (event: SyntheticKeyboardEvent<HTMLDivElement>) => {
    if (event.key !== 'Escape') return;
    toggleOpen();
  };

  const handleClick = () => {
    if (modalHasFocus) return;
    toggleOpen();
  };

  const displayModalBox = () => (
    <div
      className={`modalBackdrop ${css.modalBackdrop}`}
      onClick={handleClick}
      onKeyDown={handleKeyPress}
      tabIndex="0"
      role="button"
    >
      <div
        className={`modal ${css.modalBox}`}
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDesc"
        onMouseOver={() => setModalHasFocus(true)}
        onMouseLeave={() => setModalHasFocus(false)}
        onFocus={() => setModalHasFocus(true)}
        onBlur={() => setModalHasFocus(false)}
      >
        {displayModalHeader()}
        {displayModalBody()}
      </div>
    </div>
  );

  const resolveComponent = (component: string) => {
    /** Really only returns Avatar right now but more could be added if needed */
    switch (component) {
      case 'Avatar':
      default:
        return Avatar;
    }
  };

  const resolveElement = () => {
    let renderComponent;
    if (element && element.component) {
      const { component, props: elementProps } = element;
      renderComponent = React.createElement(resolveComponent(component), {
        ...elementProps,
      });
    }
    if (element) {
      return (
        <div
          id={elementId}
          className={`modalElement ${css.modalElement}`}
          onClick={toggleOpen}
          onKeyDown={toggleOpen}
          role="button"
          tabIndex={0}
        >
          {renderComponent || displayContent(element)}
        </div>
      );
    }
    return null;
  };

  return (
    <div>
      {resolveElement()}
      {open ? displayModalBox() : null}
    </div>
  );
};

export default ({
  element,
  elementId,
  title,
  openListener,
  open,
  body,
}: Props) => (
  <Modal
    element={element}
    elementId={elementId}
    title={title}
    openListener={openListener}
    body={body}
    open={open}
  />
);
