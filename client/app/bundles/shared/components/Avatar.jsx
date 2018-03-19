// @flow
import React from 'react';
import css from './Avatar.scss';

type Props = {
  src: string,
  alt: string,
  name?: string
};

const Avatar = (props: Props) => {
  const { name, src, alt } = props;
  const avatarClassNames = `${css.avatar} ${name ? css.white : ''}`;
  const nameTag = name ? <div>{name}</div> : '';

  return (
    <div className={avatarClassNames}>
      <img src={src} alt={alt} />
      {nameTag}
    </div>
  );
};

Avatar.defaultProps = {
  name: null,
};

export default Avatar;
