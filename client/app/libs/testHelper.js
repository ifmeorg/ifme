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
   *
   * The newer jsdom requires validation for two methods: submit and requestSubmit.
   * The previous solution used a complete error message string stored in a variable.
   * Since both methods share the same prefix, we removed the variable and now use
   * a partial match in includes(), covering both methods with a single check.
   */
  if (
    args
    && typeof args[0] === 'string'
    && args[0].includes('Not implemented: HTMLFormElement.prototype.')
  ) {
    return false;
  }

  global.originalLogError(...args);

  return true;
};

export { React, TestUtils };
