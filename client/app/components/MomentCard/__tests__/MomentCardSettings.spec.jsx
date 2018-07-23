// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCardSettings } from '../MomentCardSettings';

describe('MomentCardSettings', () => {
  it('renders MomentCard setting', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <MomentCardSettings
          action={{
            edit: () => {},
            delete: () => {},
            viewer: () => {},
          }}
          cardType="Normal"
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
