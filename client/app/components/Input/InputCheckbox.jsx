// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faQuestion } from '@fortawesome/free-solid-svg-icons';
import css from './Input.scss';
import globalCss from '../../styles/_global.scss';
import type { Checkbox as Props } from './index';
import { Tooltip } from '../Tooltip';

export type State = {
  checked: boolean,
};

export class InputCheckbox extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checked: !!props.checked };
  }

  displayUnchecked = () => {
    const { name, uncheckedValue, id } = this.props;
    return <input id={id} name={name} type="hidden" value={uncheckedValue} />;
  };

  toggleChecked = () => {
    const { checked } = this.state;
    const { onClick, id } = this.props;
    if (onClick) {
      onClick({ checked: !checked, id });
    }
    this.setState({ checked: !checked });
  };

  displayInfo = () => {
    const { info } = this.props;
    if (!info) return null;
    return (
      <Tooltip
        element={<FontAwesomeIcon icon={faQuestion} />}
        text={info}
        right
      />
    );
  };

  render() {
    const {
      id, name, value, label, uncheckedValue,
    } = this.props;
    const { checked } = this.state;
    return (
      <div className={`${css.checkbox} ${globalCss.gridRowSpaceBetween}`}>
        <div>
          {typeof uncheckedValue !== 'undefined' && this.displayUnchecked()}
          <input
            id={id}
            name={name}
            type="checkbox"
            value={value}
            defaultChecked={checked}
            onClick={this.toggleChecked}
          />
          <div className={css.checkboxLabel}>{renderHTML(label)}</div>
        </div>
        {this.displayInfo()}
      </div>
    );
  }
}
