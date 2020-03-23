// @flow

export type Link = {
  name: string,
  url: string,
  active?: boolean,
  dataMethod?: string,
  hideInMobile?: boolean,
};

export type Profile = {
  avatar?: string,
  name: string,
  profile: Link,
  account: Link,
  notifications: {
    plural: string,
    none: string,
    clear: string,
  },
};
