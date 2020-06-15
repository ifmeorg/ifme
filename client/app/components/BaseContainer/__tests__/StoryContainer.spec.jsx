// @flow
import React from 'react';
import { render } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import { StoryContainer } from '../StoryContainer';

describe('StoryContainer', () => {
  it('renders correctly', () => {
    const { container } = render(<StoryContainer data={[]} />);
    expect(container.firstChild).not.toBeNull();
  });
});
