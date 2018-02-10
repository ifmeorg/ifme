import React from "react";
import css from "./TagGhostXs.scss";

class TagGhostXs extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const containerClass = `${css.container}`;
    return (
      <p className = {css.text}>
        <span class= {containerClass}>Self-Injury</span>
      </p>
    );
  }
}
export default TagGhostXs;
