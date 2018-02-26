//@flow
import React from "react";
import css from "./Tag.scss";

type Props = {
  dark?: boolean,
  normal?: boolean,
  label?: string,
  id?: string,
};

export default class Tag extends React.Component<Props> {
  constructor(props: Props);
  super(props);
  }

  render() {
     const {dark,normal,label,id} = this.props;
     const labelClassNames = `${css.label} ${dark ? css.dark : ""}${normal ? css.normal : ""}`;

     return (
       <span>
         <div className = {labelClassNames}>{label}</div>
       </span>
     );
  }
}
