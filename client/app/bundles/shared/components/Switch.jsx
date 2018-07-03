// @flow
import React from 'react';
import css from './Switch.scss';

type Props = {
  id?: string
};

type State = {
  checked: boolean
};

export default class Switch extends React.Component<Props, State> {
  constructor(props) {
    super(props);
    this.state = { checked: props.checked || false };
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange() {
    this.setState({ checked: !this.state.checked })
  }

  render () {
    const switchClassNames = `${css.switch}`;
    const sliderClassNames = `${css.slider}`;
    return (
    <div>
      <label className = {switchClassNames}>
        <input type="checkbox" value={this.state} onChange={this.handleChange}/>
        <div className = {sliderClassNames}></div>
      </label>
    </div>
    );
  }
}
