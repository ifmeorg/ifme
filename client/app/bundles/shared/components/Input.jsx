//@flow
import React from "react";
import css from "./Input.scss";

type Props = {
    dark?: boolean;
    type? : string;
    placeholder? : string;
    label? : string;
    value? : string;

};

export default class Input extends React.Component<Props, {}> {
    constructor(props){
        super(props);
        this.state = {value: this.props.value || ''}
    }

    onChange = (e) => {
        e.preventDefault();
        this.setState({value: e.target.value});
    }

  render() {
      console.log("This is value")
      console.log(this.state.value);

      const {
          name,
          placeholder="Placeholder",
          type
      } = this.props;

    return (
      <div>
        <div>
          <div className={css.labelDark}>Hello</div>
          <input className={css.inputDark} type={type} name={name} value={this.state.value} placeholder={placeholder} onChange={this.onChange} />
        </div>
        <div>
          <div className={css.labelLight}>Hello</div>
          <input className={css.inputLight} type={type} value={this.state.value}/>
        </div>
      </div>
    );
  }
}
