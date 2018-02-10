import React from "react";
import css from "./TagGhostXs.scss";

class TagDarkXs extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <span class= {css.container}>
        <p className = {css.text}>
          Self-Injury
        </p>
    </span>

    );
  }
}
export default TagDarkXs;
