// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryDraft } from '../StoryDraft';

describe('StoryDraft', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(<StoryDraft draft="DRAFT" />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
