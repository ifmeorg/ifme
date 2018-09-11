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

export type Actions = {
  edit?: string,
  delete?: string,
  viewers?: string,
};

export type Props = {
  link: string,
  actions: Actions,
};

const EDIT = 'edit';
const DELETE = 'delete';
const VIEWERS = 'viewers';

const classMap = {
  edit: <FontAwesomeIcon icon={faPencilAlt} className={css.action} />,
  delete: <FontAwesomeIcon icon={faTrash} className={css.action} />,
  viewers: <FontAwesomeIcon icon={faLock} className={css.action} />,
};

const getHref = (actions: Actions, link: string, item: string) => {
  if (item === EDIT) {
    return actions[item];
  }
  return link;
};

const displayTooltip = (actions: Actions, item: string) => (
  <div key={item}>
    <Tooltip element={classMap[item]} text={actions[item]} right />
  </div>
);

const displayLink = (actions: Actions, link: string, item: string) => (
  <div key={item}>
    <a
      href={getHref(actions, link, item)}
      data-method={item === DELETE ? DELETE : null}
      data-confirm={item === DELETE ? actions[item] : null}
    >
      {classMap[item]}
    </a>
  </div>
);

const displayItem = (actions: Actions, link: string, item: string) => {
  if (item === EDIT || item === DELETE) {
    return displayLink(actions, link, item);
  }
  return displayTooltip(actions, item);
};

export const StoryActions = (props: Props) => {
  const { actions, link } = props;
  return (
    <div className={css.actions}>
      {[EDIT, DELETE, VIEWERS].map(
        (item: string) => (actions[item] ? displayItem(actions, link, item) : null),
      )}
    </div>
  );
};
