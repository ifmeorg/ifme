// @flow
import LazyLoad from 'react-lazyload';
import React from 'react';

import defaultAvatar from 'app/assets/images/default_ifme_avatar.png';
import css from './Avatar.scss';

// TODO: Pass in desired height in props and remove height from CSS
const DEFAULT_HEIGHT = 150;

type Props = {
  className?: string,
  displayname?: boolean,
  name?: string,
  src: string,
};

type ImgOptionalAttributes = {
  title?: string,
};

function onErrorHandler(e: Event) {
  (e.target: window.HTMLImgElement).src = defaultAvatar;
}

const Avatar = (props: Props) => {
  const { className = '', displayname = false, name = '', src } = props;

  /*
   * The `title` attribute will display a label upon hovering over the image,
   * but it's only useful if the name is not displayed beneath the image. We don't want
   * it to get in the way of the image if it's not needed.
   */
  const imgAttributes: ImgOptionalAttributes = {};
  if (!displayname) {
    imgAttributes.title = name;
  }
  const nameTag = displayname ? (
    <div className={`${css.name} name`}>{name}</div>
  ) : null;

  return (
    <div className={`${css.avatar} ${className} avatar`}>
      <LazyLoad height={DEFAULT_HEIGHT} offset={DEFAULT_HEIGHT} once>
        <img
          alt={name}
          className={`${css.portrait} portrait`}
          onError={onErrorHandler}
          src={src}
          {...imgAttributes}
        />
      </LazyLoad>
      {nameTag}
    </div>
  );
};

Avatar.defaultProps = {
  className: '',
  displayname: false,
  name: '',
};

export default Avatar;
