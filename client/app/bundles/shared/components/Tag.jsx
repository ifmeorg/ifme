import React from "react";
import css from "./Tag.scss";
type Props = {
  label?: string,
  };

export default class Tag extends React.Component<Props> {
  render()
   {
    const {label} = this.props;
    return (
      <span class= {css.container}>
        <p className = {css.text}>
          {label}
        </p>
    </span>
  );
}
}
