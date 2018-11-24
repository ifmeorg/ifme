// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCaretDown } from '@fortawesome/free-solid-svg-icons';
import css from './Input.scss';
import type { Option } from './utils';

export type Props = {
  id: string,
  name?: string,
  ariaLabel?: string,
  label?: string,
  value?: any,
  options: Option[],
  onChange?: Function,
};

export type State = {
  value: any,
};

export class InputSelect extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { value: props.value };
  }

  toggleValue = (e: SyntheticEvent<HTMLInputElement>) => {
    const { onChange } = this.props;
    this.setState({ value: e.currentTarget.value });
    if (onChange) {
      onChange(e);
    }
  };

  render() {
    const {
      id, name, options, ariaLabel, label,
    } = this.props;
    const { value } = this.state;
    return (
      <div className={css.select}>
        <div className={css.selectIcon}>
          <FontAwesomeIcon icon={faCaretDown} />
        </div>
        <select
          id={id}
          name={name}
          aria-label={label || ariaLabel}
          value={value}
          onChange={this.toggleValue}
        >
          {options.map((option: Option) => (
            <option id={option.id} value={option.value} key={option.value}>
              {renderHTML(option.label)}
            </option>
          ))}
        </select>
      </div>
    );
  }
}
