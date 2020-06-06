// @flow
import React, { useState, type Element } from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes } from '@fortawesome/free-solid-svg-icons';
import css from './Modal.scss';
import { I18n } from '../../libs/i18n';
import { Avatar } from '../Avatar';

type CustomElement = {
  component: string,
  props: Object,
};

export type Props = {
  element?: CustomElement | Element<any>,
  elementId?: string,
  body: string | Element<any> | any,
  title?: string,
  openListener?: Function,
  open?: boolean,
  className?: string,
};

type ModalPropsExtended = Props & {
  modalKey?: string,
};

export type State = {
  open: boolean,
  modalHasFocus: boolean,
};

export const Modal = (props: Props) => {
  const {
    element,
    elementId,
    body,
    title,
    openListener,
    open: openProps,
    className,
  } = props;

  const [open, setOpen] = useState(!!openProps);
  const [modalHasFocus, setModalHasFocus] = useState(true);

  const displayContent = (content: string | any) => {
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
          className={`modalElement ${css.modalElement} ${className || ''}`}
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
    <>
      {resolveElement()}
      {open ? displayModalBox() : null}
    </>
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({
  element,
  elementId,
  title,
  openListener,
  open,
  body,
  modalKey,
  className,
}: ModalPropsExtended) => (
  <Modal
    element={element}
    elementId={elementId}
    title={title}
    openListener={openListener}
    body={body}
    open={open}
    key={modalKey}
    className={className}
  />
);
