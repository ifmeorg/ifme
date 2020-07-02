// @flow
import React from 'react';
import { render } from '@testing-library/react';
import SkipToContent from '../index';

describe('SkipToContent', () => {
  it('renders correctly', () => {
    let wrapper;
    expect(() => {
      wrapper = render(<SkipToContent id="test" />);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
