import React from 'react';
import axios from 'axios';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import MomentTemplates from 'pages/MomentTemplates';

const templates = [
  {
    id: 1,
    name: 'Template 1',
    description: 'Template 1 Description',
  },
  {
    id: 2,
    name: 'Template 2',
    description: 'Template 2 Description',
  },
];

const component = <MomentTemplates templates={templates} />;

describe('MomentTemplates', () => {
  afterEach(() => {
    jest.restoreAllMocks();
  });

  describe('when there are no templates', () => {
    it('renders the component and adds premade templates', async () => {
      const premadeOne = {
        id: 1,
        name: 'Basic',
        description: 'Description',
      };
      const premadeTwo = {
        id: 2,
        name: 'Gratitude',
        description: 'Description',
      };

      jest
        .spyOn(axios, 'post')
        .mockResolvedValueOnce({
          data: premadeOne,
        })
        .mockResolvedValueOnce({
          data: premadeTwo,
        });

      const { container } = render(<MomentTemplates />);
      expect(screen.getByText('Moment Templates')).toBeInTheDocument();
      expect(screen.getByText('New Template')).toBeInTheDocument();

      const basic = screen.getByText(premadeOne.name);
      expect(basic).toBeInTheDocument();
      userEvent.click(basic);
      expect(screen.getByRole('dialog')).toBeInTheDocument();
      userEvent.click(container.querySelector('div[aria-label="close"]'));

      const gratitude = screen.getByText(premadeTwo.name);
      expect(gratitude).toBeInTheDocument();
      userEvent.click(gratitude);
      expect(screen.getByRole('dialog')).toBeInTheDocument();
      userEvent.click(container.querySelector('div[aria-label="close"]'));

      userEvent.click(screen.getByText('Add all'));

      await waitFor(() => {
        expect(screen.queryByText('Add all')).toBeNull();
        expect(screen.getByText(premadeOne.name)).toBeInTheDocument();
        expect(screen.getByText(premadeTwo.name)).toBeInTheDocument();
        expect(
          container.querySelectorAll('a[aria-label="Edit"]').length,
        ).toEqual(2);
        expect(
          container.querySelectorAll('a[aria-label="Delete"]').length,
        ).toEqual(2);
      });
    });
  });

  describe('when there are templates', () => {
    it('renders the component', () => {
      render(component);
      expect(screen.getByText('Moment Templates')).toBeInTheDocument();
      expect(screen.getByText('New Template')).toBeInTheDocument();
      expect(screen.getByText(templates[0].name)).toBeInTheDocument();
      expect(screen.getByText(templates[1].name)).toBeInTheDocument();
    });
  });
});
