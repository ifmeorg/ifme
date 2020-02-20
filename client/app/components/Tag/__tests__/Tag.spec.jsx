// @flow
import { shallow } from 'enzyme';
import React from 'react';
import { Tag } from '../index';
import css from '../Tag.scss';

describe('Tag', () => {
  describe('Class Names', () => {
    it('supports dark class', () => {
      const tag = shallow(<Tag dark />);
      expect(tag.prop('className')).toEqual(expect.stringContaining(css.dark));
    });

    it('supports normal class', () => {
      const tag = shallow(<Tag normal />);
      expect(tag.prop('className')).toEqual(
        expect.stringContaining(css.normal),
      );
    });

    it('supports secondary class', () => {
      const tag = shallow(<Tag secondary />);
      expect(tag.prop('className')).toEqual(
        expect.stringContaining(css.secondary),
      );
    });
  });
});
