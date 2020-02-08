// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Resources } from '../index';

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
          'iOS',
        ],
        languages: ['English', 'Español'],
      },
      {
        name: 'A Canvas of the Minds',
        link: 'https://acanvasoftheminds.com/',
        tags: ['free', 'blog'],
        languages: ['English'],
      },
    ]}
    history={history}
  />
);

describe('Resources', () => {
  it('adds tag to filter when tag label clicked', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(2);
    expect(wrapper.find('.tags').exists()).toEqual(true);
    expect(wrapper.text()).toContain('2 of 2');
    const id = wrapper
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
  });

  it('filters when tag selected', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(2);
    expect(wrapper.text()).toContain('2 of 2');
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
    expect(wrapper.text()).toContain('1 of 1');
    expect(
      wrapper
        .find('.tag')
        .findWhere((t) => t.text() === id)
        .exists(),
    ).toEqual(true);
  });

  it('unfilters when tag unselected', () => {
    const wrapper = mount(getComponent());
    expect(wrapper.find('.resource').length).toEqual(2);
    expect(wrapper.text()).toContain('2 of 2');
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
    wrapper.find(`input#${id}`).prop('onChange')({
      currentTarget: { checked: false },
    });
    wrapper.update();
    expect(wrapper.find('.resource').length).toEqual(2);
    expect(wrapper.text()).toContain('2 of 2');
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
            { checked: true, value: 'alfredo', label: 'Alfredo' },
            { checked: true, value: 'batman', label: 'Batman' },
            { checked: false, value: 'vitor', label: 'Vitor' },
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
