// @flow
import React from 'react';
import css from './Story.scss';

export type Props = {
  name: string,
  link: ?string,
  onClick?: Function,
};

export const StoryName = ({ name, link, onClick }: Props) => {
  if (link) {
    return (
      <a className={css.name} href={link}>
        {name}
      </a>
    );
  } else if (onClick) {
    return (<button type="button" className={css.name} onClick={onClick}>
      {name}
    </button>);
  }
  return <span className={css.name}>{name}</span>;
};
