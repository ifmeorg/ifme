// @flow
import React from 'react';
import css from './Checkbox.scss';

export type Props = {
  id: string,
  label: string,
  checked?: boolean,
  updateAllChecked?: (id: string, checked: boolean) => void,
};

export type State = {
  checked: boolean,
};

export class Checkbox extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checked: props.checked || false };
  }

  toggle = () => {
    const { updateAllChecked, id } = this.props;
    this.setState((prevState: State) => {
      if (updateAllChecked) {
        updateAllChecked(id, !prevState.checked);
      }
      return { checked: !prevState.checked };
    });
  };

  render() {
    const { id, label } = this.props;
    const { checked } = this.state;
    const checkboxClassNames = `checkbox ${css.checkbox} ${
      checked ? css.checkboxChecked : css.checkboxUnchecked
    }`;
    const labelClassNames = `checkboxLabel ${css.checkboxLabel}`;
    return (
      <div className={css.checkboxWrapper} id={id}>
        <div
          role="presentation"
          className={checkboxClassNames}
          onClick={this.toggle}
          onKeyDown={this.toggle}
        />
        <label htmlFor={id} className={labelClassNames}>
          {label}
        </label>
      </div>
    );
  }
}
