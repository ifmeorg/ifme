import React from 'react';
import { render } from '@testing-library/react';
import CrisisPrevention from 'widgets/CrisisPrevention';

describe('CrisisPrevention', () => {
  it('renders the component', () => {
    let container;
    expect(() => {
      container = render(<CrisisPrevention />);
    }).not.toThrow();
    expect(container).not.toBeNull();
  });
});
