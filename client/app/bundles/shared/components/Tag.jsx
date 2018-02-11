//@flow
import React from "react";
import css from "./Tag.scss";

type Props = {
  dark?: boolean,
  label?: string,
  id?: string,
  };

export default class Tag extends React.Component<Props> {
  constructor(props: Props)
  {super(props);}
  render()
   {
     const {dark,label,id} = this.props;
     const labelClassNames = `${css.label} ${dark ? css.dark : ""}`;
     const tagClassNames = `${css.tag} ${dark ? css.dark : ""}`;
          return (
        <div>
          <tag
            className = {tagClassNames}
            id = {id}/>
            <p className = {labelClassNames}>{label}</p>
        </div>
  );
}
}
