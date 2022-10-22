const { randomString, getPusher } = require('../index');

describe('Utils', () => {
  describe('randomString ', () => {
    it('should return random string', () => {
      expect(typeof randomString()).toBe('string');
    });
  });

  describe('getPusher', () => {
    it('should return null if window.Pusher is not defined', () => {
      const pusher = getPusher();
      expect(pusher).toBe(null);
    });
    it('should return new window.Pusher if window.Pusher is defined', () => {
      window.Pusher = jest.fn();
      const pusher = getPusher();
      expect(pusher).toBeInstanceOf(window.Pusher);
    });
  });
});
