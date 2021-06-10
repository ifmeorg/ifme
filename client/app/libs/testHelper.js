/* eslint-disable import/no-extraneous-dependencies */
import React from 'react';
import TestUtils from 'react-dom/test-utils';

Object.defineProperty(window, 'alert', {
  value: () => {},
  writable: true,
});

Object.defineProperty(window.document, 'execCommand', {
  value: () => {},
  writable: true,
});

Object.defineProperty(window, 'scrollTo', {
  value: () => {},
  writable: true,
});

Object.defineProperty(window, 'location', {
  writable: true,
  value: () => {},
});

Object.defineProperty(window.location, 'reload', {
  writable: true,
  value: () => {},
});

Object.defineProperty(window.location, 'origin', {
  writable: true,
  value: 'https://if-me.org',
});

export { React, TestUtils };
