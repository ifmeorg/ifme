// @flow
import axios from 'axios';

const randomString = () => Math.random().toString(36).substring(2, 15)
  + Math.random().toString(36).substring(2, 15);

const setCsrfToken = () => {
  const tokenDom = document.querySelector('meta[name=csrf-token]');
  if (tokenDom) {
    const csrfToken = tokenDom.getAttribute('content');
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;
  }
};

const getPusher = () => {
  if (window.Pusher) {
    const metaPusherKey = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter((item) => item.getAttribute('name') === 'pusher-key')[0];
    return new window.Pusher(metaPusherKey.getAttribute('content'), {
      cluster: 'us3',
    });
  }
  return null;
};

export const Utils = {
  randomString,
  setCsrfToken,
  getPusher,
};
