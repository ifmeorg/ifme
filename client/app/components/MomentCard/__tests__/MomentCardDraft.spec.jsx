// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCardDraft } from '../MomentCardDraft';

describe('MomentCardDraft', () => {
  it('renders MomentCard draft', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<MomentCardDraft draftText="DRAFT" />);
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
