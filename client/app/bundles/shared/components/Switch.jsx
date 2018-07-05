// @flow
import React from 'react';
import css from './Switch.scss';

type Props = {
  id?: string
}

type State = {
  checked: boolean
};

export default class Switch extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { checked: this.props.checked || false };
  }

  handleChange = () => {
    this.setState({ checked: !this.state.checked });
  };

  render() {
    return (
      <div>
        <label className={css.switch}>
          <input type="checkbox" onClick={this.handleChange} />
          <div className={css.slider}>{}</div>
        </label>
      </div>
    );
  }
}
