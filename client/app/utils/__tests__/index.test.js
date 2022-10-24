import Utils from '../index';

describe('Utils', () => {
  describe('randomString ', () => {
    it('should return random string', () => {
      expect(typeof Utils.randomString()).toBe('string');
    });
  });

  describe('getPusher', () => {
    it('should return null if window.Pusher is not defined', () => {
      expect(Utils.getPusher()).toBe(null);
    });
    it('should return new window.Pusher if window.Pusher is defined', () => {
      window.Pusher = jest.fn();
      const pusher = Utils.getPusher();
      expect(pusher).toBeInstanceOf(window.Pusher);
    });
  });
});
