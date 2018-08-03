// @flow
import LazyLoad from 'react-lazyload';
import React from 'react';
import defaultAvatar from '../../../../app/assets/images/default_ifme_avatar.png';
import css from './Avatar.scss';

// TODO: Pass in desired height in props and remove height from CSS
const DEFAULT_HEIGHT = 150;

export interface Props {
  className?: string;
  displayName?: boolean;
  name?: string;
  src: string;
}

export interface ImgOptionalAttributes {
  title?: string;
}

const onErrorHandler = (e: Event) => {
  (e.target: window.HTMLImgElement).src = defaultAvatar;
};

export const Avatar = (props: Props) => {
  const { className = '', displayName = false, name = '', src } = props;
  const imgAttributes: ImgOptionalAttributes = {};
  if (!displayName) {
    imgAttributes.title = name;
  }
  const nameTag = displayName ? (
    <div className={`${css.name} name`}>{name}</div>
  ) : null;
  return (
    <div className={`${css.avatar} ${className} avatar`}>
      <LazyLoad height={DEFAULT_HEIGHT} offset={DEFAULT_HEIGHT} once>
        <img
          alt={name}
          className={`${css.portrait} portrait`}
          onError={(e: Event) => onErrorHandler(e)}
          src={src || defaultAvatar}
          {...imgAttributes}
        />
      </LazyLoad>
      {nameTag}
    </div>
  );
};
