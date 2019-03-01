// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Resources } from '../index';

const getComponent = props => (
  <Resources
    keywords={[]}
    resources={[
      {
        name: '7 Cups',
        link: 'https://www.7cups.com',
        tags: [
          'therapy',
          'counseling',
          'paid',
          'free',
          'texting',
          'android',
          'iOS',
        ],
        languages: ['English', 'Español'],
        type: 'Services',
      },
      {
        name: 'A Canvas of the Minds',
        link: 'https://acanvasoftheminds.com/',
        tags: ['free', 'blog'],
        languages: ['English'],
        type: 'Communities',
      },
    ]}
    {...props}
  />
);

describe('Resources', () => {
  it('filters when tag selected', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(2);
    wrapper.find('.tagAutocomplete').simulate('focus');
    expect(wrapper.find('.tagMenu').exists()).toEqual(true);
    const id = wrapper
      .find('.tagLabel')
      .at(0)
      .text();
    expect(id).toEqual('android');
    wrapper
      .find('.tagLabel')
      .at(0)
      .simulate('click');
    expect(wrapper.find('.checkboxLabel').text()).toEqual(id);
    expect(wrapper.find('.resource').length).toEqual(1);
    expect(wrapper.find('.tag').findWhere(t => t.text() === id).length).toEqual(
      1,
    );
  });

  it('unfilters when tag unselected', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(2);
    wrapper.find('.tagAutocomplete').simulate('focus');
    const id = wrapper
      .find('.tagLabel')
      .at(0)
      .text();
    expect(id).toEqual('android');
    wrapper
      .find('.tagLabel')
      .at(0)
      .simulate('click');
    expect(wrapper.find('.resource').length).toEqual(1);
    wrapper.find(`input#${id}`).prop('onChange')({
      currentTarget: { checked: false },
    });
    wrapper.update();
    expect(wrapper.find('.resource').length).toEqual(2);
  });

  describe('when the component updates', () => {
    const history = { replace: () => null };
    let historyMock;

    beforeEach(() => {
      historyMock = jest.spyOn(history, 'replace');
    });

    afterEach(() => {
      historyMock.mockRestore();
    });

    describe('and the resources are being filtered', () => {
      it('sends the selected tags to the URL', () => {
        const wrapper = mount(getComponent({ history }));

        wrapper.setState({
          checkboxes: [
            { checked: true, value: 'alfredo' },
            { checked: true, value: 'batman' },
            { checked: false, value: 'vitor' },
          ],
        });

        expect(historyMock).toHaveBeenCalledWith({
          pathname: '/resources',
          search: '?filter[]=alfredo&filter[]=batman',
        });
      });
    });

    describe('and there is no filters selected', () => {
      it('resets the search query parameter', () => {
        const wrapper = mount(getComponent({ history }));

        wrapper.setState({
          checkboxes: [],
        });

        expect(historyMock).toHaveBeenCalledWith({
          pathname: '/resources',
          search: '',
        });
      });
    });
  });
});
