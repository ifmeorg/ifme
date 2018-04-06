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
    const labelClassNames = `label ${css.label} ${dark ? css.dark : ''}${normal ? css.normal : ''}`;
    return (<span className={labelClassNames}>{label}</span>);
  }
}
