import React from 'react';
import axios from 'axios';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import CarePlanContacts from 'widgets/CarePlanContacts';

const contacts = [
  {
    id: 1,
    name: 'Test1 Lastname',
  },
  {
    id: 2,
    name: 'Test2 Lastname',
    phone: '4161234567',
  },
];

const component = <CarePlanContacts contacts={contacts} />;

describe('CarePlanContacts', () => {
  afterEach(() => {
    jest.restoreAllMocks();
  });

  it('renders the component', () => {
    render(component);

    expect(screen.getByRole('heading')).toBeInTheDocument();
    expect(screen.getByText('New Contact')).toBeInTheDocument();
    expect(screen.getByText(contacts[0].name)).toBeInTheDocument();
    expect(screen.getByText(contacts[1].name)).toBeInTheDocument();
    expect(screen.getByText(contacts[1].phone)).toBeInTheDocument();
  });

  describe('when editing a contact', () => {
    it('opens a modal and submits the form successfully', async () => {
      const newPhoneNumber = '4160000000';
      jest.spyOn(axios, 'patch').mockResolvedValue({
        data: {
          id: 1,
          name: 'Test1 Lastname',
          phone: newPhoneNumber,
        },
      });
      const { container } = render(component);

      const editLink = container.querySelector('a[aria-label="Edit"]');
      expect(screen.queryByText('Edit Contact')).not.toBeInTheDocument();

      await userEvent.click(editLink);
      expect(screen.getByText('Edit Contact')).toBeInTheDocument();
      expect(screen.getByLabelText('Name')).toHaveDisplayValue(
        contacts[0].name,
      );
      expect(screen.getByLabelText('Phone number')).toHaveDisplayValue('');

      await userEvent.type(
        screen.getByLabelText('Phone number'),
        newPhoneNumber,
      );
      expect(screen.getByLabelText('Phone number')).toHaveDisplayValue(
        newPhoneNumber,
      );

      await userEvent.click(screen.getByText('Submit'));
      await waitFor(() => expect(screen.getByText(newPhoneNumber)).toBeInTheDocument());
    });

    it('opens a modal and does not submit the form successfully', async () => {
      const error = new Error('Error');
      const axiosPostSpy = jest.spyOn(axios, 'patch').mockRejectedValue(error);
      const { container } = render(component);

      const editLink = container.querySelector('a[aria-label="Edit"]');
      expect(screen.queryByText('Edit Contact')).not.toBeInTheDocument();

      await userEvent.click(editLink);
      expect(screen.getByText('Edit Contact')).toBeInTheDocument();
      expect(screen.getByLabelText('Name')).toHaveDisplayValue(
        contacts[0].name,
      );
      expect(screen.getByLabelText('Phone number')).toHaveDisplayValue('');

      await userEvent.click(screen.getByText('Submit'));
      await waitFor(() => expect(axiosPostSpy()).rejects.toEqual(error));
      expect(screen.queryByText('Error: Error')).toBeInTheDocument();
    });
  });

  describe('when creating a contact', () => {
    it('opens a modal and submits the form successfully', async () => {
      const newName = 'Test3 Lastname';
      const newPhoneNumber = '4160000000';
      jest.spyOn(axios, 'post').mockResolvedValue({
        data: {
          id: 1,
          name: newName,
          phone: newPhoneNumber,
        },
      });
      render(<CarePlanContacts />);

      await userEvent.click(screen.getByText('New Contact'));
      const nameField = screen.getByLabelText('Name');
      const phoneNumberField = screen.getByLabelText('Phone number');
      expect(nameField).toHaveDisplayValue('');
      expect(phoneNumberField).toHaveDisplayValue('');

      await userEvent.type(nameField, newName);
      await userEvent.type(phoneNumberField, newPhoneNumber);
      await userEvent.click(screen.getByText('Submit'));
      await waitFor(() => {
        expect(screen.getByText(newName)).toBeInTheDocument();
        expect(screen.getByText(newPhoneNumber)).toBeInTheDocument();
      });
    });

    it('opens a modal and does not submit the form successfully', async () => {
      const newName = 'Test3 Lastname';
      const newPhoneNumber = '4160000000';
      const error = new Error('Error');
      const axiosPostSpy = jest.spyOn(axios, 'post').mockRejectedValue(error);
      render(<CarePlanContacts />);

      await userEvent.click(screen.getByText('New Contact'));
      const nameField = screen.getByLabelText('Name');
      const phoneNumberField = screen.getByLabelText('Phone number');

      await userEvent.type(nameField, newName);
      await userEvent.type(phoneNumberField, newPhoneNumber);
      await userEvent.click(screen.getByText('Submit'));
      await waitFor(() => expect(axiosPostSpy()).rejects.toEqual(error));
      expect(screen.queryByText('Error: Error')).toBeInTheDocument();
    });
  });
});
