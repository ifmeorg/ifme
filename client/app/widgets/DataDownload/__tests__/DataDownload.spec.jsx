// @flow
import React from 'react';
import { fetchWrapper } from 'utils/fetchWrapper';
import {
  render,
  screen,
  waitFor,
  fireEvent,
  act,
} from '@testing-library/react';
import { DataDownload } from 'widgets/DataDownload';

jest.mock('libs/i18n', () => ({
  I18n: {
    t: (key) => {
      const keys = {
        'users.data_download.request': 'Request Download',
        'users.data_download.processing': 'Your data is being prepared...',
        'users.data_download.download': 'Download Data (CSV)',
        'users.data_download.request_new': 'Request New Download',
        'users.data_download.error': 'Something went wrong. Please try again.',
      };
      return keys[key] || key;
    },
  },
}));

jest.mock('utils', () => ({
  Utils: {
    setCsrfToken: jest.fn(),
  },
}));

describe('DataDownload', () => {
  beforeEach(() => {
    jest.useFakeTimers();
  });

  afterEach(() => {
    jest.useRealTimers();
    jest.restoreAllMocks();
  });

  it('renders the request button in idle state', () => {
    render(<DataDownload />);
    expect(screen.getByText('Request Download')).toBeInTheDocument();
  });

  it('shows processing state after submitting a request', async () => {
    jest.spyOn(fetchWrapper, 'post').mockResolvedValueOnce({
      data: { request_id: 'test-uuid-123' },
    });
    jest.spyOn(fetchWrapper, 'get').mockResolvedValue({
      data: { current_status: 1 },
    });

    render(<DataDownload />);
    fireEvent.click(screen.getByText('Request Download'));

    await waitFor(() => {
      expect(
        screen.getByText('Your data is being prepared...'),
      ).toBeInTheDocument();
    });
  });

  it('shows download link when data is ready', async () => {
    const requestId = 'test-uuid-456';
    jest.spyOn(fetchWrapper, 'post').mockResolvedValueOnce({
      data: { request_id: requestId },
    });
    jest.spyOn(fetchWrapper, 'get').mockResolvedValueOnce({
      data: { current_status: 2 },
    });

    render(<DataDownload />);
    fireEvent.click(screen.getByText('Request Download'));

    await waitFor(() => {
      expect(fetchWrapper.post).toHaveBeenCalledWith('/users/data');
    });

    await act(async () => {
      jest.advanceTimersByTime(3000);
    });

    await waitFor(() => {
      const link = screen.getByText('Download Data (CSV)');
      expect(link).toBeInTheDocument();
      expect(link).toHaveAttribute(
        'href',
        `/users/data/download?request_id=${requestId}`,
      );
    });
  });

  it('shows error message when request fails', async () => {
    jest
      .spyOn(fetchWrapper, 'post')
      .mockRejectedValueOnce(new Error('Network error'));

    render(<DataDownload />);
    fireEvent.click(screen.getByText('Request Download'));

    await waitFor(() => {
      expect(screen.getByRole('alert')).toBeInTheDocument();
      expect(
        screen.getByText('Something went wrong. Please try again.'),
      ).toBeInTheDocument();
    });
    expect(screen.getByText('Request Download')).toBeInTheDocument();
  });

  it('shows error message when polling indicates failure', async () => {
    jest.spyOn(fetchWrapper, 'post').mockResolvedValueOnce({
      data: { request_id: 'test-uuid-789' },
    });
    jest.spyOn(fetchWrapper, 'get').mockResolvedValueOnce({
      data: { current_status: 3 },
    });

    render(<DataDownload />);
    fireEvent.click(screen.getByText('Request Download'));

    await waitFor(() => {
      expect(fetchWrapper.post).toHaveBeenCalledWith('/users/data');
    });

    await act(async () => {
      jest.advanceTimersByTime(3000);
    });

    await waitFor(() => {
      expect(screen.getByRole('alert')).toBeInTheDocument();
    });
    expect(screen.getByText('Request Download')).toBeInTheDocument();
  });

  it('resets to idle state when request new download is clicked', async () => {
    const requestId = 'test-uuid-reset';
    jest.spyOn(fetchWrapper, 'post').mockResolvedValueOnce({
      data: { request_id: requestId },
    });
    jest.spyOn(fetchWrapper, 'get').mockResolvedValueOnce({
      data: { current_status: 2 },
    });

    render(<DataDownload />);
    fireEvent.click(screen.getByText('Request Download'));

    await waitFor(() => {
      expect(fetchWrapper.post).toHaveBeenCalledWith('/users/data');
    });

    await act(async () => {
      jest.advanceTimersByTime(3000);
    });

    await waitFor(() => {
      expect(screen.getByText('Download Data (CSV)')).toBeInTheDocument();
    });

    fireEvent.click(screen.getByText('Request New Download'));
    expect(screen.getByText('Request Download')).toBeInTheDocument();
  });
});
