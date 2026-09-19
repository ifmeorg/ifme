// @flow
import React from 'react';
import { render } from '@testing-library/react';
import { Skeleton } from 'components/Skeleton';

describe('Skeleton', () => {
  it('marks the loading area as busy and hides the placeholder', () => {
    const { container } = render(<Skeleton height="300px" />);
    const wrapper = container.firstChild;
    expect(wrapper).toHaveAttribute('aria-busy', 'true');
    expect(wrapper.firstChild).toHaveAttribute('aria-hidden', 'true');
  });

  it('reserves the given height and fills the width by default', () => {
    const { container } = render(<Skeleton height="300px" />);
    expect(container.firstChild.firstChild).toHaveStyle({
      height: '300px',
      width: '100%',
    });
  });

  it('uses the given width', () => {
    const { container } = render(<Skeleton height="20px" width="50%" />);
    expect(container.firstChild.firstChild).toHaveStyle({ width: '50%' });
  });
});
