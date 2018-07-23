// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCardMoods } from '../MomentCardMoods';

describe('MomentCardMoods', () => {
  it('renders MomentCard moods', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <MomentCardMoods mood={['NERVOUS', 'ANXIOUS', 'HELPFUL']} />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
