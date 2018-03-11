// @flow
import React from 'react';
import css from './Avatar.scss';

type Props = {
  name?: string,
  src?: string,
  alt?: string
};

const Avatar = (props: Props) => {
  const { name, src, alt } = props;
  const avatarClassNames = `${css.avatar} ${name ? css.white : ''}`;
  const nameTag = name ? <p>{name}</p> : '';

  return (
    <div className={avatarClassNames}>
    	<img src={src} alt={alt} />
    	{nameTag}
    </div>
  );
}


export default Avatar