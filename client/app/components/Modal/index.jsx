// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes } from '@fortawesome/free-solid-svg-icons';
import css from './Modal.scss';

export interface Props {
  element: any;
  body: any;
  title?: string;
}

export interface State {
  open: boolean;
}

export class Modal extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { open: false };
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
          className={css.modalBoxHeaderClose}
          onClick={() => this.toggleOpen()}
          role="button"
          tabIndex={0}
          aria-label="Close" // TODO: intl in React not working in Rails
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
    <div id="modalBackdrop" className={css.modalBackdrop}>
      <div
        id="modal"
        className={css.modalBox}
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
    this.setState({ open: !open });
  };

  render() {
    const { element } = this.props;
    const { open } = this.state;
    return (
      <div className={css.modal}>
        <div
          className={`modalElement ${css.modalElement}`}
          onClick={() => this.toggleOpen()}
          role="button"
          tabIndex={0}
        >
          {this.displayContent(element)}
        </div>
        {open ? this.displayModalBox() : null}
      </div>
    );
  }
}
