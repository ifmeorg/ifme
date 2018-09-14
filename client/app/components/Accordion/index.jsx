// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretDown, faCaretUp } from '@fortawesome/free-solid-svg-icons';
import globalCss from '../../styles/_global.scss';
import css from '../Input/Input.scss';

export type Props = {
  children: any,
  title: any,
  dark?: boolean,
  large?: boolean,
};

export type State = {
  open: boolean,
};

export class Accordion extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { open: false };
  }

  displayContent = () => {
    const { children } = this.props;
    const { open } = this.state;
    return (
      <div className={`${open ? 'accordionContent' : css.accordionClose}`}>
        {typeof children === 'string' ? renderHTML(children) : children}
      </div>
    );
  };

  toggleOpen = () => {
    const { open } = this.state;
    this.setState({ open: !open });
  };

  inputClassNames = () => {
    const { dark, large } = this.props;
    return `${dark ? css.dark : ''} ${large ? css.large : ''}`;
  };

  render() {
    const { title } = this.props;
    const { open } = this.state;
    return (
      <div className={this.inputClassNames()}>
        <div
          className={`accordion ${globalCss.gridRowSpaceBetween} ${
            css.accordion
          }`}
          onClick={this.toggleOpen}
          onKeyDown={this.toggleOpen}
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
        {this.displayContent()}
      </div>
    );
  }
}
