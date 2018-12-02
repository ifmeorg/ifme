// @flow
import React from 'react';
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
          onClick={this.toggleOpen}
          onKeyDown={this.toggleOpen}
          role="button"
          tabIndex={0}
          aria-label={I18n.t('close')}
        >
          <FontAwesomeIcon icon={faTimes} color="#6D0839" />
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

  resolveElement = () => {
    const { element, elementId } = this.props;
    let renderComponent;
    if (element && element.component) {
      const { component, props } = element;
      renderComponent = React.createElement(this.resolveComponent(component), {
        ...props,
      });
    }
    if (element) {
      return (
        <div
          id={elementId}
          className={`modalElement ${css.modalElement}`}
          onClick={this.toggleOpen}
          onKeyDown={this.toggleOpen}
          role="button"
          tabIndex={0}
        >
          {renderComponent || this.displayContent(element)}
        </div>
      );
    }
    return null;
  };

  resolveComponent = (component: string) => {
    /** Really only returns Avatar right now but more could be added if needed */
    switch (component) {
      case 'Avatar':
      default:
        return Avatar;
    }
  };

  render() {
    const { open } = this.state;
    const renderElement = this.resolveElement();
    return (
      <div>
        {renderElement}
        {open ? this.displayModalBox() : null}
      </div>
    );
  }
}
