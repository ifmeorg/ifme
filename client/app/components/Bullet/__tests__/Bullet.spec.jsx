// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Bullet } from '../index';
import css from '../Bullet.scss';

describe('Bullet', () => {
  describe('Class Names', () => {
    it('supports normal class', () => {
      const tag = shallow(<Bullet normal />);
      expect(tag.prop('className')).toEqual(
        expect.stringContaining(css.normal),
      );
    });

    it('supports active class', () => {
      const tag = shallow(<Bullet active />);
      expect(tag.prop('className')).toEqual(
        expect.stringContaining(css.active),
      );
    });
  });
});
