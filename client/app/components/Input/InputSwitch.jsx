// @flow
import React from 'react';
import { Utils } from '../../utils';
import { Input } from './index';
import css from './InputSwitch.scss';
import { I18n } from '../../libs/i18n';

export type Props = {
  id: string,
  name: string,
  label: string,
  value?: any,
  checked?: boolean,
  uncheckedValue?: any,
};

export type State = {
  checked: boolean,
  key?: string,
};

export class InputSwitch extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checked: !!props.checked };
  }

  toggleChecked = () => {
    this.setState((prevState: State) => ({
      checked: !prevState.checked,
      key: Utils.randomString(),
    }));
  };

  onKeyPress = (e: SyntheticKeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      this.toggleChecked();
    }
  };

  displaySwitchHidden = () => {
    const {
      id, name, label, value, uncheckedValue,
    } = this.props;
    const { checked, key } = this.state;
    return (
      <div className={css.switchHidden}>
        <Input
          id={id}
          key={key}
          type="checkbox"
          name={name}
          label={label}
          value={value}
          uncheckedValue={uncheckedValue}
          checked={checked}
        />
      </div>
    );
  };

  render() {
    const { id } = this.props;
    const { checked } = this.state;
    return (
      <div className={css.switch}>
        <div
          className={`${css.switchWrapper} ${
            checked ? css.switchOn : css.switchOff
          }`}
        >
          <div
            id={`${id}_switch`}
            className={`switchToggle ${css.switchToggle}`}
            onClick={this.toggleChecked}
            onKeyPress={this.onKeyPress}
            role="switch"
            aria-checked={checked}
            tabIndex={0}
          >
            {checked ? I18n.t('true') : I18n.t('false')}
          </div>
        </div>
        {this.displaySwitchHidden()}
      </div>
    );
  }
}
