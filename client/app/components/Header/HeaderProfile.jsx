// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBell } from '@fortawesome/free-solid-svg-icons';
import { Profile } from './index';
import { Notifications } from '../../widgets/Notifications';
import css from './Header.scss';
import globalCSS from '../../styles/_global.scss';

export interface Props {
  profile: Profile;
}

const notificationsElement = notifications => (
  <button className="buttonGhostXS" aria-label={notifications}>
    <FontAwesomeIcon icon={faBell} />
  </button>
);

const displayInfoLinks = (headerProfile: Profile) => {
  const { profile, account, notifications } = headerProfile;
  return (
    <div className={css.headerProfileInfoLinks}>
      <div>
        <a href={profile.url} className={globalCSS.buttonGhostXS}>
          {profile.name}
        </a>
      </div>
      <div>
        <a href={account.url} className={globalCSS.buttonGhostXS}>
          {account.name}
        </a>
      </div>
      <div>
        <Notifications
          element={notificationsElement(notifications.plural)}
          plural={notifications.plural}
          none={notifications.none}
          clear={notifications.clear}
        />
      </div>
    </div>
  );
};

export const HeaderProfile = (props: Props) => {
  const { profile } = props;
  return (
    <div className={css.headerProfile}>
      {/* <div className={css.headerProfilePicture}>
        <Avatar src={profile.avatar} />
      </div> */}
      <div className={css.headerProfileInfo}>
        <div>{profile.name}</div>
        {displayInfoLinks(profile)}
      </div>
    </div>
  );
};
