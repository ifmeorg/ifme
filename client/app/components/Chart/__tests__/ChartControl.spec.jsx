/**
 * @flow
 * Enzyme samples: https://gist.github.com/richardscarrott/d89b37aff55ccc504193335198e676d1
 */
import React from 'react';
import { render, screen } from '@testing-library/react';
import { ChartControl } from '../ChartControl';

describe('ChartControl', () => {
  it('renders', () => {
    const { container } = render(
      <ChartControl
        types={['Moments']}
        initialParams={{
          type: 'Moments',
          data: {
            Moments: {
              '2013-02-10 00:00:00 -0800': 11,
              '2013-02-11 00:00:00 -0800': 6,
            },
          },
        }}
      />,
    );

    const button = screen.getByRole('button', { name: 'Moments' });
    expect(button).toBeInTheDocument();
    expect(container.querySelector('canvas')).toBeInTheDocument();
  });
});
