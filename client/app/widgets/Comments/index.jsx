// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { StoryBy } from '../../components/Story/StoryBy';
import { StoryDate } from '../../components/Story/StoryDate';
import { StoryActions } from '../../components/Story/StoryActions';
import { DynamicForm } from '../../components/Form/DynamicForm';
import css from './Comments.scss';
import { I18n } from '../../libs/i18n';
import { Utils } from '../../utils';

type Comment = {
  id: number,
  commentByUid: string,
  commentByName: string,
  commentByAvatar?: string,
  comment: any,
  viewers?: string,
  createdAt: string,
  deletable: boolean,
};

export type Props = {
  comments?: Comment[],
  formProps: any,
};

export type State = {
  comments?: Comment[],
  key?: string,
};

export class Comments extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { comments: props.comments };
  }

  getActions = (viewers: ?string, deletable: boolean) => (
    {
      delete: deletable && {
        name: I18n.t('common.actions.delete'),
        link: 'blah',
        dataConfirm: I18n.t('common.actions.confirm'),
        dataMethod: 'delete',
      },
      viewers,
    }
  )

  displayComment = (myComment: Comment) => {
    const {
      id,
      commentByUid,
      commentByName,
      commentByAvatar,
      comment,
      viewers,
      createdAt,
      deletable,
    } = myComment;
    const author = <a href={`/profile?uid=${commentByUid}`}>{commentByName}</a>;
    return (
      <div key={id} className={css.comment}>
        <div className={css.commentContent}>
          {renderHTML(comment)}
        </div>
        <StoryDate date={createdAt} />
        <div className={css.commentInfo}>
          <StoryBy avatar={commentByAvatar} author={author} />
          <StoryActions
            actions={this.getActions(viewers, deletable)}
            hasStory
          />
        </div>
      </div>
    );
  }

  onCreate = (response: any) => {
    const { data } = response;
    if (data && data.comment) {
      this.setState((prevState: State) => {
        const { comments } = prevState;
        comments.unshift(data.comment);
        return { comments, key: Utils.randomString() };
      });
    }
  }

  render() {
    const { formProps } = this.props;
    const { comments, key } = this.state;
    return (
      <div>
        <DynamicForm
          formProps={formProps}
          onCreate={this.onCreate}
          key={key}
        />
        <div className={`${comments ? css.comments : ''}`}>
          {comments.map((comment: Comment) => this.displayComment(comment))}
        </div>
      </div>
    );
  }
}
