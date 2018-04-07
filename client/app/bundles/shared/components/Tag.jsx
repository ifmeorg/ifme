// @flow
import React from 'react';
import css from './Tag.scss';

type Props = {
  dark?: boolean,
  normal?: boolean,
  label?: string,
};

export default class Tag extends React.Component<Props> {
  render() {
    const { dark, normal, label } = this.props;
    const labelClassNames = `${css.label} ${dark ? css.dark : ''}${normal ? css.normal : ''}`;

    return (
      <span>
        <div className={labelClassNames}>{label}</div>
      </span>
    );
  }
}
