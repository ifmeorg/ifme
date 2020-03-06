// @flow
import React from 'react';
import css from './Input.scss';

export type State = {
  hidden: true,
  password: "",
};

export class InputPassword extends React.Component<State> {
  constructor() {
    super();

    this.state = {
      hidden: true,
      password: ""
    };

    this.handlePasswordChange = this.handlePasswordChange.bind(this);
    this.toggleShow = this.toggleShow.bind(this);
  }

  handlePasswordChange(e) {
    this.setState({ password: e.target.value });
  }

  toggleShow() {
    this.setState({ hidden: !this.state.hidden });
  }

  componentDidMount() {
    if (this.props.password) {
      this.setState({ password: this.props.password });
    }
  }

  render() {
    return (
      <div>
        <input
          type={this.state.hidden ? "password" : "text"}
          value={this.state.password}
          onChange={this.handlePasswordChange}
        />
        <button className="show" onClick={this.toggleShow}>Show/Hide</button>
      </div>
    );
  }
}
