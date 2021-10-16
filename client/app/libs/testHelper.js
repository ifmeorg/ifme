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

global.originalLogError = global.console.error;

global.console.error = (...args) => {
  /**
   * Avoid jsdom error message after submitting a form
   * https://github.com/jsdom/jsdom/issues/1937
   */
  const errorMessage = 'Not implemented: HTMLFormElement.prototype.submit';

  if (args && args[0].includes(errorMessage)) {
    return false;
  }

  global.originalLogError(...args);

  return true;
};

export { React, TestUtils };
