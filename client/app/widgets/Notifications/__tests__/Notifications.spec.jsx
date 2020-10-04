// @flow
import React from 'react';
import axios from 'axios';
import {
  render, screen, waitFor, fireEvent,
} from '@testing-library/react';
import { Notifications } from 'widgets/Notifications';

const button = <button type="button">Notifications</button>;

describe('Notifications', () => {
  it('gets notifications and clears them', async (done) => {
    jest
      .spyOn(axios, 'get')
      .mockReturnValueOnce(Promise.resolve({ data: { signed_in: 1 } }))
      .mockReturnValueOnce(
        Promise.resolve({ data: { fetch_notifications: ['Hello'] } }),
      );
    jest
      .spyOn(axios, 'delete')
      .mockReturnValue(Promise.resolve({ data: { ok: true } }));
    render(<Notifications element={button} />);
    await waitFor(() => expect(axios.get).toHaveBeenCalledWith('/notifications/signed_in'));
    await waitFor(() => expect(axios.get).toHaveBeenCalledWith(
      '/notifications/fetch_notifications',
    ));
    expect(axios.get).toHaveBeenCalledTimes(2);
    expect(screen.getByText('Hello')).toBeInTheDocument();
    fireEvent.click(screen.getByText('Clear'));
    await waitFor(() => {
      expect(screen.queryByText('Hello')).not.toBeInTheDocument();
    });
    done();
  });
});
