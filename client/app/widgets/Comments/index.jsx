// @flow
import React from 'react';
import axios from 'axios';
import renderHTML from 'react-render-html';
import { StoryBy } from '../../components/Story/StoryBy';
import { StoryDate } from '../../components/Story/StoryDate';
import { StoryActions } from '../../components/Story/StoryActions';
import DynamicForm from '../../components/Form/DynamicForm';
import css from './Comments.scss';
import { I18n } from '../../libs/i18n';
import { Utils } from '../../utils';
import type { FormProps } from '../../components/Form/utils';

type CommentResponse = {
  data: {
    comment: string,
    id: string,
  },
};

type Comment = {
  id: number,
  currentUserUid: number,
  commentByUid: string,
  commentByName: string,
  commentByAvatar?: string,
  comment: any,
  viewers?: string,
  createdAt: string,
  deleteAction?: string,
};

export type Props = {
  comments?: Comment[],
  formProps: FormProps,
};

export type State = {
  comments: (Comment | any)[],
  key?: string,
};

export class Comments extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { comments: props.comments || [] };
  }

  onDeleteClick = (e: SyntheticEvent<HTMLInputElement>, action: string) => {
    e.preventDefault();
    axios.delete(action).then((response: CommentResponse) => {
      const { data } = response;
      if (data && data.id) {
        this.setState((prevState: State) => {
          const { comments } = prevState;
          const newComments = comments.filter(
            (comment: Comment) => comment.id !== parseInt(data.id, 10),
          );
          return { comments: newComments };
        });
      }
    });
  };

  reportAction = (uid: string, id: number) => ({
    name: I18n.t('common.actions.report'),
    link: `/reports/new?uid=${uid}&comment_id=${id}`,
  });

  getActions = (
    viewers: ?string,
    deleteAction: ?string,
    currentUserUid: number,
    uid: string,
    id: number,
  ) => {
    const actions = {};
    if (currentUserUid !== uid) {
      actions.report = this.reportAction(uid, id);
    }
    if (viewers) {
      actions.viewers = viewers;
    }
    if (deleteAction) {
      actions.delete = {
        name: I18n.t('common.actions.delete'),
        link: deleteAction,
        dataConfirm: I18n.t('common.actions.confirm'),
        onClick: this.onDeleteClick,
      };
    }
    return actions;
  };

  displayComment = (myComment: Comment) => {
    const {
      id,
      currentUserUid,
      commentByUid,
      commentByName,
      commentByAvatar,
      comment,
      viewers,
      createdAt,
      deleteAction,
    } = myComment;
    const author = <a href={`/profile?uid=${commentByUid}`}>{commentByName}</a>;
    return (
      <article key={id} className={`comment ${css.comment}`}>
        <div className={css.commentContent}>{renderHTML(comment)}</div>
        <StoryDate date={createdAt} />
        <div className={css.commentInfo}>
          <StoryBy avatar={commentByAvatar} author={author} />
          <StoryActions
            actions={this.getActions(
              viewers,
              deleteAction,
              currentUserUid,
              commentByUid,
              id,
            )}
            hasStory
          />
        </div>
      </article>
    );
  };

  onCreate = (response: CommentResponse) => {
    const { data } = response;
    if (data && data.comment) {
      this.setState((prevState: State) => {
        const { comments } = prevState;
        return {
          comments: [data.comment].concat(comments),
          key: Utils.randomString(),
        };
      });
    }
  };

  displayComments = () => {
    const { comments } = this.state;
    if (comments.length === 0) return null;
    return (
      <section className={css.comments} aria-label={I18n.t('comment.plural')}>
        {comments.map((comment: Comment) => this.displayComment(comment))}
      </section>
    );
  };

  render() {
    const { formProps } = this.props;
    const { key } = this.state;
    return (
      <div id="comments">
        <DynamicForm formProps={formProps} onCreate={this.onCreate} key={key} />
        {this.displayComments()}
      </div>
    );
  }
}
