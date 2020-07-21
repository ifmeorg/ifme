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
}

export const Utils = {
  randomString,
  setCsrfToken
};