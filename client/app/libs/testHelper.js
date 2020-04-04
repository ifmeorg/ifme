/* eslint-disable import/no-extraneous-dependencies */
import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });
window.alert = () => {};
window.document.execCommand = () => {};

Object.defineProperty(window, 'scrollTo', {
  value: () => {},
  writable: true,
});

Object.defineProperty(window, 'location', {
  writable: true,
  value: { assign: () => {} },
});

Object.defineProperty(window.location, 'reload', {
  writable: true,
  value: { assign: () => {} },
});

Object.defineProperty(window.location, 'origin', {
  writable: true,
  value: 'https://if-me.org',
});

export { React, TestUtils };
