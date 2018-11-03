// @flow
import React from 'react';
import axios from 'axios';
import { mount } from 'enzyme';
import { Comments } from '../index';

let axiosPostSpy;
let axiosDeleteSpy;

const formProps = {
  inputs: [
    {
      id: 'comment_commentable_type',
      name: 'comment[commentable_type]',
      type: 'hidden',
      value: 'moment',
    },
    {
      id: 'comment_comment_by',
      name: 'comment[comment_by]',
      type: 'hidden',
      value: 1,
    },
    {
      id: 'comment_commentable_id',
      name: 'comment[commentable_id]',
      type: 'hidden',
      value: 19,
    },
    {
      id: 'comment_comment',
      name: 'comment[comment]',
      type: 'textarea',
      dark: true,
    },
    {
      options: [
        {
          id: 'comment_visibility_all',
          label: 'Share with everyone',
          value: 'all',
        },
        {
          id: 'comment_visibility_private',
          label: 'Share with Testy 2 only',
          value: 'private',
        },
      ],
      id: 'comment_visibility',
      name: 'comment[visibility]',
      type: 'select',
      value: 'all',
      dark: true,
    },
    {
      id: 'submit',
      type: 'submit',
      value: 'Submit',
      dark: true,
    },
  ],
  action: '/comment/create',
  noFormTag: true,
};

const value = 'Hey';

const id = 1;

const comment = {
  comment: value,
  currentUserId: 'some-uid',
  commentByAvatar: null,
  commentByName: 'Kind Human',
  commentByUid: 'uid',
  createdAt: 'Created less than a minute ago',
  deleteAction: '/comment/delete?comment_id=1',
  id,
  viewers: 'Visible only between you and Lane Kim',
};

const component = <Comments formProps={formProps} />;

describe('Comments', () => {
  beforeEach(() => {
    axiosPostSpy = jest.spyOn(axios, 'post').mockImplementation(() => Promise.resolve({
      data: { comment },
    }));
    axiosDeleteSpy = jest.spyOn(axios, 'delete').mockImplementation(() => Promise.resolve({
      data: { id },
    }));
  });

  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = mount(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });

  it('add and delete a comment', async () => {
    const wrapper = mount(component);
    expect(wrapper.find('.comment').exists()).toEqual(false);
    wrapper.find('input[name="comment[comment]"]').simulate('change', {
      currentTarget: { value },
    });
    wrapper.find('select#comment_visibility').prop('onChange')({
      currentTarget: { value: 'private' },
    });
    wrapper.find('input[type="submit"]').simulate('click');
    await axiosPostSpy();
    wrapper.update();
    expect(wrapper.find('.comment').exists()).toEqual(true);
    wrapper
      .find('.storyActionsDelete')
      .find('a')
      .simulate('click');
    await axiosDeleteSpy();
    wrapper.update();
    expect(wrapper.find('.comment').exists()).toEqual(false);
  });
});
