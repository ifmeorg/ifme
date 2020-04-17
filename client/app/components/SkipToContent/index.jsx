// @flow
import React from 'react';
import css from './SkipToContent.scss';

export type Props = {
  id?: string,
};

function SkipToContent(props: Props) {

  return <a className={css.skipToContent} href={`#${props.id}`}>Skip to main content</a>;
}

export default SkipToContent;

