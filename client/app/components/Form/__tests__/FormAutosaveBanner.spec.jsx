// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { FormAutosaveBanner } from 'components/Form/FormAutosaveBanner';

const onRestore = jest.fn();
const onDismiss = jest.fn();

const renderBanner = (savedAt = Date.now()) => render(
  <FormAutosaveBanner
    savedAt={savedAt}
    onRestore={onRestore}
    onDismiss={onDismiss}
  />,
);

describe('FormAutosaveBanner', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders the restore and dismiss buttons', () => {
    renderBanner();
    expect(screen.getByRole('button', { name: /restore draft/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /dismiss/i })).toBeInTheDocument();
  });

  it('shows "just now" for a timestamp within the last minute', () => {
    renderBanner(Date.now());
    expect(screen.getByRole('status')).toHaveTextContent('just now');
  });

  it('shows minutes when the draft is a few minutes old', () => {
    const fiveMinutesAgo = Date.now() - 5 * 60 * 1000;
    renderBanner(fiveMinutesAgo);
    expect(screen.getByRole('status')).toHaveTextContent('5 minutes ago');
  });

  it('shows "1 minute ago" when the draft is exactly 1 minute old', () => {
    const oneMinuteAgo = Date.now() - 60 * 1000;
    renderBanner(oneMinuteAgo);
    expect(screen.getByRole('status')).toHaveTextContent('1 minute ago');
  });

  it('shows "1 hour ago" when the draft is exactly 1 hour old', () => {
    const oneHourAgo = Date.now() - 60 * 60 * 1000;
    renderBanner(oneHourAgo);
    expect(screen.getByRole('status')).toHaveTextContent('1 hour ago');
  });

  it('calls onRestore when the restore button is clicked', async () => {
    renderBanner();
    await userEvent.click(screen.getByRole('button', { name: /restore draft/i }));
    expect(onRestore).toHaveBeenCalledTimes(1);
  });

  it('calls onDismiss when the dismiss button is clicked', async () => {
    renderBanner();
    await userEvent.click(screen.getByRole('button', { name: /dismiss/i }));
    expect(onDismiss).toHaveBeenCalledTimes(1);
  });
});
