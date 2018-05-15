// @flow
import React from 'react';

import Avatar from 'bundles/shared/components/Avatar';
import photoJulia from 'app/assets/images/contributors/julia_nguyen.jpg';

import css from './ProfileModal.scss';

type Props = {
  bio: string,
  name: string,
  location: string,
  github: string,
};

const ProfileModal = (props: Props) => {
  const {
    bio = 'bio',
    name = 'name',
    location = 'location',
    github = 'github'
  } = props;

  return (
    <div className={`${css.profileModal}`}>
      <span className={`${css.name}`}>{name}</span>
      <p>
        <span>{location}</span>
        <span>{github}</span>
      </p>
      <p className={`${css.bio}`}>{bio}</p>
    </div>
  );
};

export default ProfileModal;
