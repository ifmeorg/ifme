// @flow
import React from 'react';
import renderHTML from 'react-render-html';
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
          {this.displayCloseSvg()}
        </div>
      </div>
    );
  };

  displayCloseSvg = () => (
    <svg width="36" height="35" viewBox="0 0 36 35" fill="#D0839" xmlns="http://www.w3.org/2000/svg">
      <path
        fillRule="evenodd"
        clipRule="evenodd"
        d="M18.4141 17.7071L34.707 34L34 34.7071L17.707 18.4141L1.41406 34.7071L0.707031 34L17 17.7071L0 0.707108L0.707031 0L17.707 17L34.707 0L35.4141 0.707108L18.4141 17.7071Z"
        fill="#D0839"
      />
    </svg>
  );

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

    if (typeof element === 'object' && element.component) {
      const { component, props } = element;
      renderComponent = React.createElement(
        this.resolveComponent(component),
        { ...props },
      );
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
  }

  resolveComponent = (component: string) => {
    /** Really only returns Avatar right now but more could be added if needed */
    switch (component) {
      case 'Avatar':
      default:
        return Avatar;
    }
  }

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
