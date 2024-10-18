// @flow
import axios from 'axios';
import { sanitize } from 'dompurify';
import React from 'react';
import parse from 'html-react-parser';

const randomString = (): string => Math.random()
  .toString(36)
  .substring(2, 15)
  + Math.random()
    .toString(36)
    .substring(2, 15);

const setCsrfToken = (): void => {
  const tokenDom = document.querySelector('meta[name=csrf-token]');
  if (tokenDom) {
    const csrfToken = tokenDom.getAttribute('content');
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;
  }
};

const getPusher = (): Object | null => {
  if (window.Pusher) {
    const metaPusherKey = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter((item) => item.getAttribute('name') === 'pusher-key')[0];
    const metaPusherCluster = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter((item) => item.getAttribute('name') === 'pusher-cluster')[0];
    return new window.Pusher(metaPusherKey.getAttribute('content'), {
      cluster: metaPusherCluster.getAttribute('content'),
    });
  }
  return null;
};

const renderContent = (content: string | any, attributes: Object = {}): any => {
  if (typeof content === 'string') {
    return parse(sanitize(content));
  }
  if (React.isValidElement(content)) {
    return React.cloneElement(content, attributes);
  }
  return content;
};

export const Utils = {
  randomString,
  setCsrfToken,
  getPusher,
  renderContent,
};
