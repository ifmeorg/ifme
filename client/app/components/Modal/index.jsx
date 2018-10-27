// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes } from '@fortawesome/free-solid-svg-icons';
import css from './Modal.scss';
import { I18n } from '../../libs/i18n';

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
};

export class Modal extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { open: !!props.open };
  }

  displayContent = (content: any) => {
    if (typeof content === 'string') {
      return renderHTML(content);
    }
    return content;
  };

  displayModalHeader = () => {
    const { title } = this.props;
    return (
      <div className={css.modalBoxHeader}>
        {title ? (
          <div
            id="modalTitle"
            className={css.modalBoxHeaderTitle}
            aria-label={title}
          >
            {title}
          </div>
        ) : null}
        <div
          className={`modalClose ${css.modalBoxHeaderClose}`}
          onClick={this.toggleOpen}
          onKeyDown={this.toggleOpen}
          role="button"
          tabIndex={0}
          aria-label={I18n.t('close')}
        >
          <FontAwesomeIcon icon={faTimes} />
        </div>
      </div>
    );
  };

  displayModalBody = () => {
    const { body } = this.props;
    return (
      <div id="modalDesc" className={css.modalBoxBody}>
        {this.displayContent(body)}
      </div>
    );
  };

  displayModalBox = () => (
    <div className={`modalBackdrop ${css.modalBackdrop}`}>
      <div
        className={`modal ${css.modalBox}`}
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDesc"
      >
        {this.displayModalHeader()}
        {this.displayModalBody()}
      </div>
    </div>
  );

  toggleOpen = () => {
    const { open } = this.state;
    const { openListener } = this.props;
    const body = ((document.body: any): HTMLBodyElement);
    if (!open) {
      body.classList.add('bodyModalOpen');
    } else {
      body.classList.remove('bodyModalOpen');
    }
    if (!open && openListener) {
      openListener();
    }
    this.setState({ open: !open });
  };

  render() {
    const { element, elementId } = this.props;
    const { open } = this.state;
    return (
      <div>
        {element ? (
          <div
            id={elementId || null}
            className={`modalElement ${css.modalElement}`}
            onClick={this.toggleOpen}
            onKeyDown={this.toggleOpen}
            role="button"
            tabIndex={0}
          >
            {this.displayContent(element)}
          </div>
        ) : null}
        {open ? this.displayModalBox() : null}
      </div>
    );
  }
}
