// @flow
import React from 'react';
import axios from 'axios';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Comments from 'widgets/Comments';

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
  action: '/comments/create',
};

const value = 'Hey';

const id = 1;

const getComment = ({ commentByAdmin } = {}) => ({
  comment: value,
  currentUserUid: 'some-uid',
  commentByAvatar: null,
  commentByAdmin: Boolean(commentByAdmin),
  commentByName: 'Kind Human',
  commentByUid: 'uid',
  createdAt: 'Created less than a minute ago',
  deleteAction: '/comments/delete?comment_id=1',
  id,
  viewers: 'Visible only between you and Lane Kim',
});

describe('Comments', () => {
  describe('when written by a non-admin user', () => {
    it('renders correctly with a report link', () => {
      render(<Comments formProps={formProps} comments={[getComment()]} />);
      expect(screen.getByRole('textbox')).toBeInTheDocument();
      expect(screen.getByRole('article')).toBeInTheDocument();
      expect(
        screen.getByRole('button', { name: 'Submit' }),
      ).toBeInTheDocument();
      expect(screen.getByRole('link', { name: 'Report' })).toBeInTheDocument();
    });

    it('add and delete a comment', async () => {
      jest.spyOn(axios, 'post').mockResolvedValue({
        data: { comment: getComment() },
      });
      jest.spyOn(axios, 'delete').mockResolvedValue({
        data: { id },
      });
      render(<Comments formProps={formProps} />);
      expect(screen.queryByRole('article')).not.toBeInTheDocument();

      userEvent.type(screen.getByRole('textbox'));
      userEvent.selectOptions(screen.getByRole('combobox'), 'private');
      userEvent.click(screen.getByRole('button', { name: 'Submit' }));

      await waitFor(() => expect(screen.getByRole('article')).toBeInTheDocument());
      expect(screen.getByRole('article')).toHaveTextContent('Hey');

      userEvent.click(screen.getByRole('link', { name: 'Delete' }));

      await waitFor(() => expect(screen.queryByRole('article')).not.toBeInTheDocument());
    });
  });

  describe('when written by an admin user', () => {
    it('renders correctly without a report link', () => {
      render(
        <Comments
          formProps={formProps}
          comments={[getComment({ commentByAdmin: true })]}
        />,
      );
      expect(screen.getByRole('textbox')).toBeInTheDocument();
      expect(screen.getByRole('article')).toBeInTheDocument();
      expect(
        screen.getByRole('button', { name: 'Submit' }),
      ).toBeInTheDocument();
      expect(
        screen.queryByRole('link', { name: 'Report' }),
      ).not.toBeInTheDocument();
    });

    it('add and delete a comment', async () => {
      jest.spyOn(axios, 'post').mockResolvedValue({
        data: { comment: getComment({ commentByAdmin: true }) },
      });
      jest.spyOn(axios, 'delete').mockResolvedValue({
        data: { id },
      });
      render(<Comments formProps={formProps} />);
      expect(screen.queryByRole('article')).not.toBeInTheDocument();

      userEvent.type(screen.getByRole('textbox'));
      userEvent.selectOptions(screen.getByRole('combobox'), 'private');
      userEvent.click(screen.getByRole('button', { name: 'Submit' }));

      await waitFor(() => expect(screen.getByRole('article')).toBeInTheDocument());
      expect(screen.getByRole('article')).toHaveTextContent('Hey');

      userEvent.click(screen.getByRole('link', { name: 'Delete' }));

      await waitFor(() => expect(screen.queryByRole('article')).not.toBeInTheDocument());
    });
  });
});
