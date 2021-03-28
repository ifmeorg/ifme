// @flow
import { queryByText, render } from '@testing-library/react';

import React from 'react';
import { HeaderProfile } from '../HeaderProfile';

const profileWithAvatar = {
  avatar: '//congue.volutpat/sollicitudin.jpg',
  name: 'Sollicitudin',
  profile: {
    name: 'Name One',
    url: '/some-path',
    active: true,
    dataMethod: 'delete',
    hideInMobile: false,
  },
  account: {
    name: 'Name Two',
    url: '/some-other-path',
    active: true,
    dataMethod: 'delete',
    hideInMobile: false,
  },
  notifications: {
    plural: 'plural',
    none: 'none',
    clear: 'clear',
  },
};

const profileWithoutAvatar = {
  name: 'Volutpat',
  profile: {
    name: 'Name One',
    url: '/some-path',
    active: true,
    dataMethod: 'delete',
    hideInMobile: false,
  },
  account: {
    name: 'Name Two',
    url: '/some-other-path',
    active: true,
    dataMethod: 'delete',
    hideInMobile: false,
  },
  notifications: {
    plural: 'plural',
    none: 'none',
    clear: 'clear',
  },
};

describe('HeaderProfile', () => {
  describe('has no avatar', () => {
    it('renders correctly', () => {
      const { container } = render(
        <HeaderProfile profile={profileWithoutAvatar} />,
      );
      const avatarSection = container.querySelector('.avatar');
      const buttonGhostXSSection = container.querySelector('.buttonGhostXS');
      expect(avatarSection).toBeInTheDocument();
      expect(buttonGhostXSSection).toBeInTheDocument();
    });
  });

  describe('has avatar', () => {
    it('renders correctly', () => {
      const { container } = render(
        <HeaderProfile profile={profileWithAvatar} />,
      );
      const avatarSection = container.querySelector('.avatar');
      const buttonGhostXSSection = container.querySelector('.buttonGhostXS');
      expect(avatarSection).toBeInTheDocument();
      expect(buttonGhostXSSection).toBeInTheDocument();
    });
  });

  describe('displayInfoLinks', () => {
    it('renders the info links correctly', () => {
      const { container } = render(
        <HeaderProfile profile={profileWithAvatar} />,
      );
      const displayLinksSection = container.querySelector(
        '.headerProfileInfoLinks',
      );
      expect(displayLinksSection).toBeInTheDocument();
      expect(
        queryByText(
          displayLinksSection,
          profileWithAvatar.profile.name,
        ).getAttribute('href'),
      ).toEqual(profileWithAvatar.profile.url);
      expect(
        queryByText(
          displayLinksSection,
          profileWithAvatar.account.name,
        ).getAttribute('href'),
      ).toEqual(profileWithAvatar.account.url);
    });
  });
});
