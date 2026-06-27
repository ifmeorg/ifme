/* eslint react/jsx-props-no-spreading: 0 */
import React from 'react';
import {
  render, screen, fireEvent, waitFor,
} from '@testing-library/react';
import { fetchWrapper } from 'utils/fetchWrapper';
import CrisisPrevention from 'widgets/CrisisPrevention';

jest.mock('utils/fetchWrapper', () => ({
  fetchWrapper: {
    post: jest.fn(() => Promise.resolve({ data: { acknowledged: true } })),
  },
}));

describe('CrisisPrevention', () => {
  const defaultProps = { momentId: 42, acknowledged: false };

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('renders the modal when not yet acknowledged', () => {
    const { container } = render(<CrisisPrevention {...defaultProps} />);
    expect(container).not.toBeNull();
    expect(screen.getByRole('dialog')).toBeInTheDocument();
  });

  it('does not render the modal when already acknowledged', () => {
    const { container } = render(
      <CrisisPrevention momentId={42} acknowledged />,
    );
    expect(container.firstChild).toBeNull();
  });

  it('renders the acknowledge button', () => {
    render(<CrisisPrevention {...defaultProps} />);
    expect(
      screen.getByRole('button', { name: /acknowledged/i }),
    ).toBeInTheDocument();
  });

  it('renders a link to the care plan', () => {
    render(<CrisisPrevention {...defaultProps} />);
    const link = screen.getByRole('link', { name: /care plan/i });
    expect(link).toBeInTheDocument();
    expect(link).toHaveAttribute('href', '/care_plan');
  });

  it('calls the acknowledge API and hides the modal when the button is clicked', async () => {
    render(<CrisisPrevention {...defaultProps} />);

    fireEvent.click(screen.getByRole('button', { name: /acknowledged/i }));

    await waitFor(() => {
      expect(fetchWrapper.post).toHaveBeenCalledWith(
        '/moments/42/acknowledge_crisis_prevention',
      );
    });

    await waitFor(() => {
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });
  });

  it('hides the modal even if the API call fails', async () => {
    fetchWrapper.post.mockRejectedValueOnce(new Error('Network error'));

    render(<CrisisPrevention {...defaultProps} />);
    fireEvent.click(screen.getByRole('button', { name: /acknowledged/i }));

    await waitFor(() => {
      expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
    });
  });

  describe('bulk mode (no momentId)', () => {
    it('renders the modal when no momentId is provided', () => {
      render(<CrisisPrevention acknowledged={false} />);
      expect(screen.getByRole('dialog')).toBeInTheDocument();
    });

    it('calls the bulk acknowledge endpoint when no momentId is provided', async () => {
      render(<CrisisPrevention acknowledged={false} />);
      fireEvent.click(screen.getByRole('button', { name: /acknowledged/i }));

      await waitFor(() => {
        expect(fetchWrapper.post).toHaveBeenCalledWith(
          '/moments/acknowledge_all_crisis_prevention',
        );
      });

      await waitFor(() => {
        expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
      });
    });
  });
});
