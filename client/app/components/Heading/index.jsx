// @flow
import React from 'react';
import css from './Heading.scss';

type Props = {
  large?: boolean,
  small?: boolean,
  text?: boolean,
  label?: string,
};

export class Heading extends React.Component<Props> {
  render() {
    const { large, small, text, label } = this.props;
    const labelClassNames = `${css.label} ${large ? css.large : ''} ${
      small ? css.small : ''
    } ${text ? css.text : ''}`;

    return <div className={labelClassNames}>{label}</div>;
  }
}
