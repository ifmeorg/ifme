// @flow
import React from 'react';
import css from './Story.scss';

export interface Props {
  name: string;
  link: string;
}

export const StoryName = (props: Props) => (
  <a className={css.name} href={props.link}>
    {props.name}
  </a>
);
