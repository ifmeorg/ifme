// @flow
import React from 'react';
import css from './Blockquote.scss';

type Props = {
  text?: string,
  author?: string,
};

export default class Blockquote extends React.Component<Props> {
  render() {
    const { text, author } = this.props;
    const textClassNames = `${css.text}`;
    return (
      <div className={textClassNames}>
        <p>
          <q>
            {text}
          </q>
        </p>
        <div style = {{paddingTop:'10px',}}>
          {author}
        </div>
      </div>
    );
  }
}
