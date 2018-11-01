// @flow
import { mount } from 'enzyme';
import React from 'react';
import { Resources } from '../index';

const component = (
  <Resources
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
  />
);

describe('Resources', () => {
  it('filters when tag selected', () => {
    const wrapper = mount(component);
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
    const wrapper = mount(component);
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
});
