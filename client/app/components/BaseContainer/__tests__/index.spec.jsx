// @flow
import React from 'react';
import axios from 'axios';
import { render, fireEvent, act } from '@testing-library/react';
import BaseContainer from 'components/BaseContainer';

const response = {
  data: {
    lastPage: true,
    data: [
      {
        name: 'Some Other Story',
        link: 'some-other-url',
        date: 'Created 3 Days ago',
      },
    ],
  },
};

// eslint-disable-next-line react/prop-types
const getComponent = ({ fetchUrl, lastPage } = {}) => (
  <BaseContainer
    container="StoryContainer"
    data={[
      {
        name: 'Some Story',
        link: 'some-url',
        date: 'Created 2 Days ago',
      },
    ]}
    fetchUrl={fetchUrl}
    lastPage={lastPage}
  />
);

describe('BaseContainer', () => {
  describe('when container prop is StoryContainer', () => {
    describe('when fetchUrl prop has no params', () => {
      const fetchUrl = '/some-fetch-url';

      describe('when lastPage prop is false', () => {
        it('renders the "Load more" button', () => {
          const { container, getByRole } = render(getComponent({ fetchUrl }));
          const loadMoreButton = getByRole('button');
          const stories = container.querySelectorAll('.story');
          expect(loadMoreButton).toBeInTheDocument();
          expect(stories.length).toEqual(1);
        });

        it('renders the next story when "Load more" button is clicked', async () => {
          const axiosGetSpy = jest
            .spyOn(axios, 'get')
            .mockImplementation(() => Promise.resolve(response));
          const { container, getByRole } = render(getComponent({ fetchUrl }));
          const loadMoreButton = getByRole('button');
          fireEvent.click(loadMoreButton);
          await act(() => axiosGetSpy());
          expect(axiosGetSpy).toBeCalledWith(
            'https://if-me.org/some-fetch-url.json?page=2',
          );
          const stories = container.querySelectorAll('.story');
          expect(loadMoreButton).not.toBeInTheDocument();
          expect(stories.length).toEqual(2);
        });
      });

      describe('when lastPage prop is true', () => {
        it('does not render the "Load more" button', () => {
          const { container, queryByRole } = render(
            getComponent({ fetchUrl, lastPage: true }),
          );
          const loadMoreButton = queryByRole('button');
          const stories = container.querySelectorAll('.story');
          expect(loadMoreButton).not.toBeInTheDocument();
          expect(stories.length).toEqual(1);
        });
      });
    });

    describe('when fetchUrl prop has params', () => {
      const fetchUrl = '/some-fetch-url?uid=some-uid';

      describe('when lastPage prop is false', () => {
        it('renders the "Load more" button', () => {
          const { container, queryByRole } = render(getComponent({ fetchUrl }));
          const loadMoreButton = queryByRole('button');
          const stories = container.querySelectorAll('.story');
          expect(loadMoreButton).toBeInTheDocument();
          expect(stories.length).toEqual(1);
        });

        it('renders the next story when "Load more" button is clicked', async () => {
          const axiosGetSpy = jest
            .spyOn(axios, 'get')
            .mockImplementation(() => Promise.resolve(response));
          const { container, queryByRole } = render(getComponent({ fetchUrl }));
          const loadMoreButton = queryByRole('button');
          fireEvent.click(loadMoreButton);
          await act(() => axiosGetSpy());
          const stories = container.querySelectorAll('.story');
          expect(axiosGetSpy).toBeCalledWith(
            'https://if-me.org/some-fetch-url.json?page=2&uid=some-uid',
          );
          expect(loadMoreButton).not.toBeInTheDocument();
          expect(stories.length).toEqual(2);
        });
      });

      describe('when lastPage prop is true', () => {
        it('does not render the "Load more" button', () => {
          const { container, queryByRole } = render(
            getComponent({ fetchUrl, lastPage: true }),
          );
          const loadMoreButton = queryByRole('button');
          const stories = container.querySelectorAll('.story');
          expect(loadMoreButton).not.toBeInTheDocument();
          expect(stories.length).toEqual(1);
        });
      });
    });
  });
});
