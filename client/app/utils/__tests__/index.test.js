import { JSDOM } from 'jsdom';
import { randomString, setCsrfToken, getPusher } from '../index';

describe('Utils', () => {
  describe('randomString ', () => {
    it('should return random string', () => {
      expect(typeof randomString()).toBe('string');
    });
  });

  describe('setCsrfToken', () => {
    it('should be equal to pusher key and cluster when getPusher is called', () => {
      const dom = new JSDOM(`
        <html>
          <head>
            <meta name="pusher-key" content="pusher-key">
            <meta name="pusher-cluster" content="pusher-cluster">
          </head>
          <body>
          </body>
        </html>
      `);

      const metaPusherKey = Array.from(
        dom.window.document.getElementsByTagName('meta'),
      ).filter((item) => item.getAttribute('name') === 'pusher-key')[0];
      const metaPusherCluster = Array.from(
        dom.window.document.getElementsByTagName('meta'),
      ).filter((item) => item.getAttribute('name') === 'pusher-cluster')[0];

      const pusher = getPusher();

      expect(pusher.key).toBe(metaPusherKey.getAttribute('content'));
      expect(pusher.config.cluster).toBe(
        metaPusherCluster.getAttribute('content'),
      );
    });
  });
});
