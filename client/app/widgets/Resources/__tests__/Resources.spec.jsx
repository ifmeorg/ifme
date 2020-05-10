// @flow
import { mount } from 'enzyme';
import React from 'react';
import { act } from 'react-dom/test-utils';
import Resources from '../index';

// eslint-disable-next-line react/prop-types
const getComponent = ({ history } = {}) => (
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
          'ios',
        ],
        languages: ['en', 'es'],
      },
      {
        name: 'A Canvas of the Minds',
        link: 'https://acanvasoftheminds.com/',
        tags: ['free', 'blog'],
        languages: ['en'],
      },
      {
        name: 'Bloom',
        link: 'http://www.getbloom.net/',
        tags: ['ios', 'paid', 'game', 'colouring', 'stress'],
        languages: ['en'],
      },
    ]}
    history={history}
  />
);

describe('Resources', () => {
  it('adds tags to filter when tag labels are clicked', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(3);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.text()).toContain('3 of 3');
    let id = wrapper
      .find('.tag')
      .at(2)
      .text();
    expect(id).toEqual('therapy');
    wrapper
      .find('.tag')
      .at(2)
      .simulate('click');
    expect(wrapper.find('.checkboxLabel').text()).toEqual(id);
    expect(wrapper.find('.resource').length).toEqual(1);
    expect(wrapper.text()).toContain('1 of 1');
    expect(
      wrapper
        .find('.tag')
        .findWhere((t) => t.text() === id)
        .exists(),
    ).toEqual(true);
    id = wrapper
      .find('.tag')
      .at(8)
      .text();
    expect(id).toEqual('ios');
    wrapper
      .find('.tag')
      .at(8)
      .simulate('click');
    expect(
      wrapper
        .find('.checkboxLabel')
        .at(0)
        .text(),
    ).toEqual(id);
    expect(wrapper.find('.resource').length).toEqual(2);
    expect(wrapper.text()).toContain('2 of 2');
    expect(
      wrapper
        .find('.tag')
        .findWhere((t) => t.text() === id)
        .exists(),
    ).toEqual(true);
  });

  it('filters when tags are selected', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(3);
    expect(wrapper.text()).toContain('3 of 3');
    wrapper.find('.tagAutocomplete').simulate('focus');
    expect(wrapper.find('.tagMenu').exists()).toEqual(true);
    let id = wrapper
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
    expect(wrapper.text()).toContain('1 of 1');
    expect(
      wrapper
        .find('.tag')
        .findWhere((t) => t.text() === id)
        .exists(),
    ).toEqual(true);
    wrapper.find('.tagAutocomplete').simulate('focus');
    id = wrapper
      .find('.tagLabel')
      .at(1)
      .text();
    expect(id).toEqual('colouring');
    wrapper
      .find('.tagLabel')
      .at(1)
      .simulate('click');
    expect(
      wrapper
        .find('.checkboxLabel')
        .at(1)
        .text(),
    ).toEqual(id);
    expect(wrapper.find('.resource').length).toEqual(2);
    expect(wrapper.text()).toContain('2 of 2');
    expect(
      wrapper
        .find('.tag')
        .findWhere((t) => t.text() === id)
        .exists(),
    ).toEqual(true);
  });

  it('unfilters when a tag is unselected', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(3);
    expect(wrapper.text()).toContain('3 of 3');
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
    expect(wrapper.text()).toContain('1 of 1');
    act(() => {
      wrapper.find(`input#${id}`).prop('onChange')({
        currentTarget: { checked: false },
      });
    });
    wrapper.update();
    expect(wrapper.find('.resource').length).toEqual(3);
    expect(wrapper.text()).toContain('3 of 3');
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

        wrapper
          .find('.tag')
          .at(8)
          .simulate('click');

        wrapper
          .find('.tag')
          .at(2)
          .simulate('click');

        expect(historyMock).toHaveBeenCalledWith({
          pathname: '/resources',
          search: '?filter[]=ios&filter[]=therapy',
        });
      });
    });

    describe('and there is no filters selected', () => {
      it('resets the search query parameter', () => {
        mount(getComponent({ history }));

        expect(historyMock).toHaveBeenCalledWith({
          pathname: '/resources',
          search: '',
        });
      });
    });
  });
});
