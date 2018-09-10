// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faPencilAlt,
  faTrash,
  faLock,
} from '@fortawesome/free-solid-svg-icons';
import css from './Story.scss';
import { Tooltip } from '../Tooltip';

export interface Props {
  link: string;
  actions: {
    edit?: string,
    delete?: string,
    viewers?: string,
  };
}

const EDIT = 'edit';
const DELETE = 'delete';
const VIEWERS = 'viewers';

const classMap = {
  edit: <FontAwesomeIcon icon={faPencilAlt} className={css.action} />,
  delete: <FontAwesomeIcon icon={faTrash} className={css.action} />,
  viewers: <FontAwesomeIcon icon={faLock} className={css.action} />,
};

const getHref = (props: Props, item: string) => {
  const { actions, link } = props;
  if (item === EDIT) {
    return actions[item];
  }
  return link;
};

const displayTooltip = (props: Props, item: string) => {
  const { actions } = props;
  return (
    <Tooltip element={classMap[item]} text={actions[item]} right />
  );
};

const displayLink = (props: Props, item: string) => {
  const { actions } = props;
  return (
    <div>
      <a
        href={getHref(props, item)}
        data-method={item === DELETE ? DELETE : null}
        data-confirm={item === DELETE ? actions[item] : null}
      >
        {classMap[item]}
      </a>
    </div>
  );
};

const displayItem = (props: Props, item: string) => {
  if (item === EDIT || item === DELETE) {
    return displayLink(props, item);
  }
  return displayTooltip(props, item);
};

export const StoryActions = (props: Props) => {
  const { actions } = props;
  return (
    <div className={css.actions}>
      {[EDIT, DELETE, VIEWERS].map((item: string) => (
        actions[item] ? displayItem(props, item) : null
      ))}
    </div>
  );
};
