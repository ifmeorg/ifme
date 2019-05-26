// @flow
import { mount } from 'enzyme';
import React from 'react';
import axios from 'axios';
import { BaseContainer } from '../index';

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
          const wrapper = mount(getComponent({ fetchUrl }));
          expect(wrapper.find('.loadMore').length).toEqual(1);
          expect(wrapper.find('.story').length).toEqual(1);
        });

        it('renders the next story when "Load more" button is clicked', async () => {
          const axiosGetSpy = jest.spyOn(axios, 'get').mockImplementation(() => Promise.resolve(response));
          const wrapper = mount(getComponent({ fetchUrl }));
          wrapper.find('.loadMore').simulate('click');
          await axiosGetSpy();
          expect(axiosGetSpy).toBeCalledWith(
            'http://localhost/some-fetch-url.json?page=2',
          );
          wrapper.update();
          expect(wrapper.find('.loadMore').length).toEqual(0);
          expect(wrapper.find('.story').length).toEqual(2);
        });
      });

      describe('when lastPage prop is true', () => {
        it('does not render the "Load more" button', () => {
          const wrapper = mount(getComponent({ fetchUrl, lastPage: true }));
          expect(wrapper.find('.loadMore').length).toEqual(0);
          expect(wrapper.find('.story').length).toEqual(1);
        });
      });
    });

    describe('when fetchUrl prop has params', () => {
      const fetchUrl = '/some-fetch-url?uid=some-uid';

      describe('when lastPage prop is false', () => {
        it('renders the "Load more" button', () => {
          const wrapper = mount(getComponent({ fetchUrl }));
          expect(wrapper.find('.loadMore').length).toEqual(1);
          expect(wrapper.find('.story').length).toEqual(1);
        });

        it('renders the next story when "Load more" button is clicked', async () => {
          const axiosGetSpy = jest.spyOn(axios, 'get').mockImplementation(() => Promise.resolve(response));
          const wrapper = mount(getComponent({ fetchUrl }));
          wrapper.find('.loadMore').simulate('click');
          await axiosGetSpy();
          expect(axiosGetSpy).toBeCalledWith(
            'http://localhost/some-fetch-url.json?page=2&uid=some-uid',
          );
          wrapper.update();
          expect(wrapper.find('.loadMore').length).toEqual(0);
          expect(wrapper.find('.story').length).toEqual(2);
        });
      });

      describe('when lastPage prop is true', () => {
        it('does not render the "Load more" button', () => {
          const wrapper = mount(getComponent({ fetchUrl, lastPage: true }));
          expect(wrapper.find('.loadMore').length).toEqual(0);
          expect(wrapper.find('.story').length).toEqual(1);
        });
      });
    });
  });
});
