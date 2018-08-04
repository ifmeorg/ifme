// @flow
import React from 'react';
import css from './RadioButton.scss';

export interface Props {
  id: string;
  label: string;
  checked?: boolean;
  updateAll?: (id: string) => void;
}

export interface State {
  checked: boolean;
}

export class RadioButton extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checked: !!this.props.checked };
  }

  shouldComponentUpdate(nextProps: Props) {
    // TODO: not working as expected
    this.setState({ checked: nextProps.checked });
    return true;
  }

  toggle = (id: string) => {
    const { updateAll } = this.props;
    this.setState({ checked: true });
    if (updateAll) {
      updateAll(id);
    }
  };

  render() {
    const { id, label } = this.props;
    const { checked } = this.state;
    const radioButtonClassNames = `radioButton ${css.radioButton} ${
      checked ? css.radioButtonChecked : css.radioButtonUnchecked
    }`;
    const labelClassNames = `radioButtonLabel ${css.radioButtonLabel}`;
    return (
      <div className={css.radioButtonWrapper} id={id}>
        <div
          role="presentation"
          className={radioButtonClassNames}
          onClick={() => this.toggle(id)}
        />
        <label htmlFor={id} className={labelClassNames}>
          {label}
        </label>
      </div>
    );
  }
}
