// @flow
import React from 'react';
import renderHTML from 'react-render-html';
import { StoryBy } from '../../components/Story/StoryBy';
import { StoryDate } from '../../components/Story/StoryDate';
import { StoryActions } from '../../components/Story/StoryActions';
import css from './Comments.scss';
import { I18n } from '../../libs/i18n';

type Comment = {
  id: number,
  commentByUid: string,
  commentByName: string,
  commentByAvatar: string,
  comment: any,
  visibility?: string,
  createdAt: string,
  deletable: boolean,
};

export type Props = {
  // commentable: boolean,
  // commentableType: string,
  // commentableUserId: number,
  // currentUserId: number,
  // noHidePage?: boolean,
  // isMember?: boolean,
  comments?: Comment[],
};

export type State = {
  comments?: Comment[],
};

export class Comments extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { comments: props.comments };
  }

  getActions = (visibility: ?string, deletable: boolean) => (
    {
      delete: deletable && {
        name: I18n.t('common.actions.delete'),
        link: 'blah',
        dataConfirm: I18n.t('common.actions.confirm'),
        dataMethod: 'delete',
      },
      viewers: visibility,
    }
  )

  displayContent = (content: any) => {
    if (typeof content === 'string') {
      return renderHTML(content);
    }
    return content;
  };

  displayComment = (myComment: Comment) => {
    const {
      id,
      commentByUid,
      commentByName,
      commentByAvatar,
      comment,
      visibility,
      createdAt,
      deletable,
    } = myComment;
    const author = <a href={`/profile?uid=${commentByUid}`}>{commentByName}</a>;
    return (
      <div key={id} className={css.comment}>
        <div className={css.commentInfo}>
          <StoryBy avatar={commentByAvatar} author={author} />
          <StoryActions
            actions={this.getActions(visibility, deletable)}
            hasStory
          />
        </div>
        <StoryDate date={createdAt} />
        <div className={css.commentContent}>
          {this.displayContent(comment)}
        </div>
      </div>
    );
  }

  render() {
    const { comments } = this.state;
    return (
      <div className="comments">
        {comments.map((comment: Comment) => this.displayComment(comment))}
      </div>
    );
  }
}
