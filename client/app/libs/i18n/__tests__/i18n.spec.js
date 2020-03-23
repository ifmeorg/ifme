// @flow
import Cookies from 'js-cookie';
import { I18n } from '../index';

const missingTranslation = '[missing "en.fake" translation]';

describe('I18n', () => {
  describe('t()', () => {
    describe('has default locale', () => {
      describe('has invalid scope', () => {
        describe('has no options', () => {
          it('returns correct result', () => {
            expect(I18n.t('fake')).toEqual(missingTranslation);
          });
        });

        describe('has options', () => {
          it('returns correct result', () => {
            expect(I18n.t('fake', { created_at: 'test' })).toEqual(
              missingTranslation,
            );
          });
        });
      });

      describe('has valid scope', () => {
        describe('has no options', () => {
          it('returns correct result', () => {
            expect(I18n.t('app_name')).toEqual('if me');
          });
        });

        describe('has valid options', () => {
          it('returns correct result', () => {
            expect(I18n.t('created', { created_at: 'test' })).toEqual(
              'Created test',
            );
          });
        });

        describe('has invalid options', () => {
          it('returns correct result', () => {
            expect(I18n.t('created', { fake: 'test' })).toEqual(
              'Created [missing {created_at} value]',
            );
          });
        });
      });
    });

    describe('has cookie locale', () => {
      describe('has invalid scope', () => {
        describe('has no options', () => {
          it('returns correct result', () => {
            expect(I18n.t('fake')).toEqual(missingTranslation);
          });
        });

        describe('has options', () => {
          it('returns correct result', () => {
            expect(I18n.t('fake', { created_at: 'test' })).toEqual(
              missingTranslation,
            );
          });
        });
      });

      describe('has valid scope', () => {
        beforeAll(() => {
          jest.spyOn(Cookies, 'get').mockImplementation(() => 'es');
        });

        describe('has no options', () => {
          it('returns correct result', () => {
            expect(I18n.t('app_name')).toEqual('if me');
          });
        });

        describe('has valid options', () => {
          it('returns correct result', () => {
            expect(I18n.t('created', { created_at: 'test' })).toEqual(
              'Creado test',
            );
          });
        });

        describe('has invalid options', () => {
          it('returns correct result', () => {
            expect(I18n.t('created', { fake: 'test' })).toEqual(
              'Creado [missing {created_at} value]',
            );
          });
        });
      });
    });
  });
});
