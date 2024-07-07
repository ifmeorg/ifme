import axios from 'axios';
import { Utils } from '../index';

describe('Utils', () => {
  describe('randomString ', () => {
    it('should return random string', () => {
      expect(typeof Utils.randomString()).toBe('string');
    });
  });

  describe('getPusher', () => {
    beforeAll(() => {
      const metaElementOne = document.createElement('meta');
      const metaElementTwo = document.createElement('meta');

      metaElementOne.setAttribute('name', 'pusher-key');
      metaElementOne.setAttribute('content', 'sample content');

      metaElementTwo.setAttribute('name', 'pusher-cluster');
      metaElementTwo.setAttribute('content', 'sample-cluster');

      jest
        .spyOn(document, 'getElementsByTagName')
        .mockImplementation(() => [metaElementOne, metaElementTwo]);
    });

    it('should return null if window.Pusher is not defined', () => {
      expect(Utils.getPusher()).toBe(null);
    });

    it('should return new window.Pusher if window.Pusher is defined', () => {
      window.Pusher = jest.fn();
      const pusher = Utils.getPusher();
      expect(pusher).toBeInstanceOf(window.Pusher);
      expect(window.Pusher).toHaveBeenCalledWith('sample content', {
        cluster: 'sample-cluster',
      });
    });
  });

  describe('setCsrfToken', () => {
    it('should verify that csrf token will be undefined if not present in meta tag', () => {
      Utils.setCsrfToken();
      expect(axios.defaults.headers.common['X-CSRF-Token']).toBe(undefined);
    });

    it('should verify that axios makes use of the CSRF token present in meta tag if defined', () => {
      const metaElementOne = document.createElement('meta');
      metaElementOne.setAttribute('name', 'csrf-token');
      metaElementOne.setAttribute('content', 'TOKEN-TEST-VALUE');

      jest
        .spyOn(document, 'getElementsByTagName')
        .mockImplementation(() => [metaElementOne]);

      Utils.setCsrfToken();
      expect(axios.defaults.headers.common['X-CSRF-Token']).toBe(
        'TOKEN-TEST-VALUE',
      );
    });
  });

  describe('renderContent', () => {
    it('should verify that render content returns the content passed in without any modification if its not a string', () => {
      const objectValue = { a: 1, b: 2 };
      const objectValueRespone = Utils.renderContent(objectValue);
      expect(objectValueRespone).toBe(objectValue);

      const integerValue = 12;
      const integerValueResponse = Utils.renderContent(integerValue);
      expect(integerValueResponse).toBe(integerValue);

      const booleanValue = false;
      const booleanValueResponse = Utils.renderContent(booleanValue);
      expect(booleanValueResponse).toBe(booleanValue);

      const listValue = ['VALUE1', 'VALUE2'];
      const listValueResponse = Utils.renderContent(listValue);
      expect(listValueResponse).toBe(listValue);

      const nullValue = null;
      const nullValueResponse = Utils.renderContent(nullValue);
      expect(nullValueResponse).toBe(nullValue);

      const undefinedValue = undefined;
      const undefinedValueResponse = Utils.renderContent(undefinedValue);
      expect(undefinedValueResponse).toBe(undefinedValue);
    });

    it('should verify that for html strings without any issues, proper object representation is created without any value missing', () => {
      const h1HeadingString = '<h1 id="main-heading">THIS IS A HEADING</h1>';
      const h1Object = Utils.renderContent(h1HeadingString);
      expect(h1Object.type).toEqual('h1');
      expect(h1Object.props.id).toEqual('main-heading');
      expect(h1Object.props.children[0]).toEqual('THIS IS A HEADING');
    });

    it('should verify that for html strings with vulnerable code, it gets sanitized in object representation', () => {
      const imageHTMLString = '<img src=img.jpg onerror=alert(1)>';
      const imageObject = Utils.renderContent(imageHTMLString);
      expect(imageObject.type).toEqual('img');
      expect(imageObject.props.src).toEqual('img.jpg');
      expect(imageObject.props.onError).toBe(undefined);
    });
  });
});
