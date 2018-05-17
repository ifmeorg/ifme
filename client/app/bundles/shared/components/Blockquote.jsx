// @flow
import React from 'react';
import css from './Blockquote.scss';

type Props = {
  label?: string,
};

export default class Blockquote extends React.Component<Props> {
  render() {
    const { label } = this.props;
    const labelClassNames = `${css.label}`;

    return (
      <div className={labelClassNames}>
        {label}
      </div>
    );
  }
}
