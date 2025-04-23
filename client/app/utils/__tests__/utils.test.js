// @flow
import { Utils } from './index';
import axios from 'axios';
import React from 'react';
import { renderToStaticMarkup } from 'react-dom/server';

describe('Utils', () => {
  describe('randomString', () => {
    it('should return a string with only lowercase alphanumeric characters', () => {
      const str = Utils.randomString();
      expect(str).toMatch(/^[a-z0-9]+$/);
    });

    it('should produce strings with a minimum length of 26 characters', () => {
      const str = Utils.randomString();
      expect(str.length).toBeGreaterThanOrEqual(26);
    });

    it('should produce different outputs over multiple invocations', () => {
      const outputs = new Set();
      for (let i = 0; i < 10; i++) {
        outputs.add(Utils.randomString());
      }
      expect(outputs.size).toBe(10);
    });
  });

  describe('setCsrfToken', () => {
    beforeEach(() => {
      document.head.innerHTML = '';
      axios.defaults.headers.common['X-CSRF-Token'] = undefined;
    });

    it('should not set anything if meta tag is missing', () => {
      Utils.setCsrfToken();
      expect(axios.defaults.headers.common['X-CSRF-Token']).toBeUndefined();
    });

    it('should set token if meta tag is present', () => {
      const meta = document.createElement('meta');
      meta.name = 'csrf-token';
      meta.setAttribute('content', 'secure-token');
      document.head.appendChild(meta);

      Utils.setCsrfToken();
      expect(axios.defaults.headers.common['X-CSRF-Token']).toBe('secure-token');
    });

    it('should overwrite an existing CSRF token if re-run', () => {
      const meta = document.createElement('meta');
      meta.name = 'csrf-token';
      meta.setAttribute('content', 'first-token');
      document.head.appendChild(meta);

      Utils.setCsrfToken();
      expect(axios.defaults.headers.common['X-CSRF-Token']).toBe('first-token');

      meta.setAttribute('content', 'updated-token');
      Utils.setCsrfToken();
      expect(axios.defaults.headers.common['X-CSRF-Token']).toBe('updated-token');
    });
  });

  describe('getPusher', () => {
    beforeEach(() => {
      document.head.innerHTML = '';
    });

    it('should return null if window.Pusher is undefined', () => {
      delete window.Pusher;
      expect(Utils.getPusher()).toBeNull();
    });

    it('should return null if required meta tags are missing', () => {
      window.Pusher = jest.fn();
      expect(Utils.getPusher()).toBeNull();
    });

    it('should return a configured Pusher instance with meta tag values', () => {
      window.Pusher = jest.fn((key, options) => ({ key, ...options }));

      const metaKey = document.createElement('meta');
      metaKey.setAttribute('name', 'pusher-key');
      metaKey.setAttribute('content', 'abc123');
      document.head.appendChild(metaKey);

      const metaCluster = document.createElement('meta');
      metaCluster.setAttribute('name', 'pusher-cluster');
      metaCluster.setAttribute('content', 'mt1');
      document.head.appendChild(metaCluster);

      const pusher = Utils.getPusher();
      expect(pusher.key).toBe('abc123');
      expect(pusher.cluster).toBe('mt1');
    });
  });

  describe('renderContent', () => {
    it('should sanitize malicious HTML and preserve safe HTML', () => {
      const malicious = `<img src=x onerror=alert(1) /><p>Hello</p>`;
      const result = Utils.renderContent(malicious);
      const html = renderToStaticMarkup(result);
      expect(html).not.toContain('onerror');
      expect(html).toContain('<p>Hello</p>');
      expect(html).not.toContain('<img'); // sanitized away
    });

    it('should return cloned React element with merged props', () => {
      const element = <button className="primary">Click</button>;
      const result = Utils.renderContent(element, { id: 'submitBtn', disabled: true });

      expect(React.isValidElement(result)).toBe(true);
      expect(result.type).toBe('button');
      expect(result.props.className).toBe('primary');
      expect(result.props.id).toBe('submitBtn');
      expect(result.props.disabled).toBe(true);
    });

    it('should override props when duplicate keys exist', () => {
      const element = <input type="text" value="default" />;
      const result = Utils.renderContent(element, { value: 'override' });
      expect(result.props.value).toBe('override');
    });

    it('should return non-string non-React values unchanged', () => {
      const obj = { foo: 'bar' };
      expect(Utils.renderContent(obj)).toEqual(obj);
    });

    it('should return null safely', () => {
      expect(Utils.renderContent(null)).toBeNull();
    });

    it('should handle undefined input gracefully', () => {
      expect(Utils.renderContent(undefined)).toBeUndefined();
    });

    it('should preserve fragments', () => {
      const fragment = <>{['One', 'Two'].map((txt, i) => <span key={i}>{txt}</span>)}</>;
      const result = Utils.renderContent(fragment, { 'data-test': 'fragment' });

      // Fragments can't be cloned with props directly, but test still returns the same JSX
      expect(React.isValidElement(result)).toBe(true);
    });
  });
});
