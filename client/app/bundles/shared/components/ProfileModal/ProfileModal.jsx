// @flow
import React from 'react';

import Avatar from 'bundles/shared/components/Avatar';

import css from './ProfileModal.scss';

type Props = {
  bio: string,
  name: string,
  location: string,
  github: string,
  photo: src,
};

const ProfileModal = (props: Props) => {
  const {
    bio = 'bio',
    name = 'name',
    location = 'location',
    github = 'github',
    photo = 'photo',
  } = props;

  return (
    <div className={`${css.profileModal}`}>
      <Avatar className={`${css.avatar}`} src={photo} name={name} displayName="false" />
      <span className={`${css.name}`}>{name}</span>
      <p className={`${css.links}`}>
        <span>{location}</span>
        <span>{github}</span>
      </p>
      <p className={`${css.bio}`}>{bio}</p>
    </div>
  );
};

export default ProfileModal;
