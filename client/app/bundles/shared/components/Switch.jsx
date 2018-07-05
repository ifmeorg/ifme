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
<<<<<<< HEAD
        <label className={css.switch}>
          <input type="checkbox" onChange={this.handleChange} />
          <div className={css.slider}>{}</div>
=======
        <label className={`${css.switch}`}>
          <input type="checkbox" onChange={this.handleChange} />
          <div className={`${css.slider}`}>{}</div>
>>>>>>> 3eb7e0acf85e7f4ae9a163abf4a826e09596086f
        </label>
      </div>
    );
  }
}
