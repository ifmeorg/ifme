// @flow
import React from 'react';
import css from './Input.scss';
import type { Password as Props } from './utils';

export type State = {
  show: boolean,
};

export class InputPassword extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { show: props.show };
  }

  ShowPassword = (show, text, onChange, onClick) => (
    <div>
      <input
        type = {show ? "password" : "text"}
        value = {text}
        onChange = {(event: SyntheticEvent<HTMLInputElement>) => this.handleOnChange(event, onChange, text)}
      />
      <div className={css.show}>
        <i className = { show ? "fa fa-eye" : "fa fa-eye-slash" } onClick = {(event: SyntheticEvent<HTMLButtonElement>) => this.toggleShow(event, onClick, show)} />
      </div>
    </div>
  );

  handleOnChange = (
    event: SyntheticEvent<HTMLInputElement>,
    onChange?: Function,
    text?: string,
  ) => {
    text = event.currentTarget.value;
    if (onChange) {
      onChange({ text });
    }
  };

  toggleShow = (
    event: SyntheticEvent<HTMLButtonElement>,
    onClick?: Function,
    show?: boolean,
  ) => {
    (event.currentTarget: HTMLButtonElement);
    console.log("SHow before ",this.state.show);
    this.setState({ show: !show });
    console.log("SHow",this.state.show);
  };

  render() {
    const {
      id, show, text, onChange, onClick
    } = this.props;
    return (
      <div>
      { this.ShowPassword(this.state.show, text, onChange, onClick) }
      </div>
    );
  }
};
