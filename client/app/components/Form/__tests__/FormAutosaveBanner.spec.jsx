// @flow
import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { FeedbackBanner } from 'components/FeedbackBanner';

const onPrimary = jest.fn();
const onSecondary = jest.fn();

const renderBanner = (message = 'Test message') => render(
  <FeedbackBanner
    message={message}
    actions={[
      { label: 'Primary', onClick: onPrimary, primary: true },
      { label: 'Secondary', onClick: onSecondary },
    ]}
  />,
);

describe('FeedbackBanner', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders the message and both action buttons', () => {
    renderBanner('You have an unsaved draft.');
    expect(screen.getByRole('status')).toHaveTextContent('You have an unsaved draft.');
    expect(screen.getByRole('button', { name: 'Primary' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Secondary' })).toBeInTheDocument();
  });

  it('calls the primary action callback when clicked', async () => {
    renderBanner();
    await userEvent.click(screen.getByRole('button', { name: 'Primary' }));
    expect(onPrimary).toHaveBeenCalledTimes(1);
  });

  it('calls the secondary action callback when clicked', async () => {
    renderBanner();
    await userEvent.click(screen.getByRole('button', { name: 'Secondary' }));
    expect(onSecondary).toHaveBeenCalledTimes(1);
  });

  it('renders with a single action', () => {
    render(
      <FeedbackBanner
        message="Done."
        actions={[{ label: 'OK', onClick: onPrimary, primary: true }]}
      />,
    );
    expect(screen.getByRole('button', { name: 'OK' })).toBeInTheDocument();
  });
});
