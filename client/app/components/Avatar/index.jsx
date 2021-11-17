// @flow
import LazyLoad from 'react-lazyload';
import React from 'react';
import css from './Avatar.scss';

export type Props = {
  name?: string,
  src?: string,
  alt?: string,
  small?: boolean,
  large?: boolean,
};

const displayImage = (alt: ?string, src: string) => (
  <img alt={alt ?? ''} className={`${css.image}`} src={src} />
);

const displayName = (name: string) => (
  <div className={`${css.name} name`}>{name}</div>
);

const getHeight = (small: ?boolean, large: ?boolean) => {
  if (small) return 50;
  if (large) return 150;
  return 100;
};

export const Avatar = (props: Props) => {
  const {
    name, alt, src, small, large,
  } = props;
  const height = getHeight(small, large);
  return (
    <div
      className={`avatar ${css.avatar} ${large ? css.large : ''} ${small ? css.small : ''}`}
    >
      <LazyLoad height={height} offset={height} once tabIndex={0}>
        {src ? (
          displayImage(alt, src)
        ) : (
          <div className={css.image} aria-hidden />
        )}
      </LazyLoad>
      {name && displayName(name)}
    </div>
  );
};
