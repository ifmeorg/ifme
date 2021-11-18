// @flow
import axios from 'axios';
import renderHTML from 'react-render-html';
import { sanitize } from 'dompurify';

const randomString = () => Math.random()
  .toString(36)
  .substring(2, 15)
  + Math.random()
    .toString(36)
    .substring(2, 15);

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
    const metaPusherCluster = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter((item) => item.getAttribute('name') === 'pusher-cluster')[0];
    return new window.Pusher(metaPusherKey.getAttribute('content'), {
      cluster: metaPusherCluster.getAttribute('content'),
    });
  }
  return null;
};

const renderContent = (content: string | any) => {
  if (typeof content === 'string') {
    return renderHTML(sanitize(content));
  }
  return content;
};

export const Utils = {
  randomString,
  setCsrfToken,
  getPusher,
  renderContent,
};
