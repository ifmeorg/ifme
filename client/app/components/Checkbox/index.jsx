// @flow
import React from 'react';
import css from './Checkbox.scss';

export interface Props {
  id: string;
  label: string;
  checked?: boolean;
  updateAllChecked?: (id: string, checked: boolean) => void;
}

export interface State {
  checked: boolean;
}

export class Checkbox extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checked: this.props.checked || false };
  }

  toggle = () => {
    const { updateAllChecked } = this.props;
    const checked = !this.state.checked;
    this.setState({ checked });
    if (updateAllChecked) {
      updateAllChecked(this.props.id, checked);
    }
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
          onClick={() => this.toggle()}
        />
        <label htmlFor={id} className={labelClassNames}>
          {label}
        </label>
      </div>
    );
  }
}
