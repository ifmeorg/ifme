// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { AreaChart } from 'react-chartkick';
import { ChartControl } from 'components/Chart/ChartControl';

/**
 * Canvas is tricky to test with 'react-testing-library', so this file mocks
 * the external 'react-chartkick' dependency. The mock component can track what
 * specific data gets passed down to the chart. A mix of shallow rendering plus
 * the recommended integration approach seemed like a good compromise here.
 */
jest.mock('react-chartkick', () => {
  const FakeAreaChart = jest.fn(() => <canvas />);
  return { AreaChart: FakeAreaChart };
});

describe('ChartControl', () => {
  beforeEach(() => {
    AreaChart.mockClear();
  });

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
    // using querySelector as a last resort for canvas
    expect(container.querySelector('canvas')).toBeInTheDocument();
  });

  it('passes down the expected data for the selected type', () => {
    const data = {
      Moments: {
        '2013-02-10 00:00:00 -0800': 11,
        '2013-02-11 00:00:00 -0800': 6,
      },
      Categories: [
        {
          data: {
            '2013-02-10': 3,
            '2013-02-11': 6,
            '2013-02-12': 13,
          },
          name: 'School',
        },
      ],
    };

    render(
      <ChartControl
        types={['Moments', 'Categories']}
        initialParams={{
          type: 'Moments',
          data,
        }}
      />,
    );

    // checks that the initial data is passed down to the mock chart component
    expect(AreaChart).toHaveBeenCalledWith(
      expect.objectContaining({ data: data.Moments }),
      {}, // ignore: forwardRef argument
    );

    // simulates a button click for the specified type
    const button = screen.getByRole('button', { name: 'Categories' });
    userEvent.click(button);

    // checks that the correct data for the updated type is passed down
    expect(AreaChart).toHaveBeenCalledWith(
      expect.objectContaining({ data: data.Categories }),
      {}, // ignore: forwardRef argument
    );
  });
});
