import React from "react";
import css from "./Button.scss";

class Button extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const containerClass = `${css.button}`;
    return (
      <button className = {containerClass} >
        <span className = {css.text}>
          Self-Injury
        </span>
      </button>
    );
  }
}
export default Button;
