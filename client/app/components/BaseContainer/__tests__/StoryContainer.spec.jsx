// @flow
import React from 'react';
import { render } from '@testing-library/react';
import { StoryContainer } from 'components/BaseContainer/StoryContainer';

describe('StoryContainer', () => {
  it('renders correctly', () => {
    const { container } = render(<StoryContainer data={[]} />);
    expect(container.firstChild).not.toBeNull();
  });
});
