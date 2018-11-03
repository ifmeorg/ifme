// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faPencilAlt,
  faTrash,
  faLock,
  faDoorOpen,
  faDoorClosed,
  faExclamationTriangle,
} from '@fortawesome/free-solid-svg-icons';
import css from './Story.scss';
import { Tooltip } from '../Tooltip';

export type Action = {
  name: string,
  link: string,
  dataMethod?: string,
  dataConfirm?: string,
  onClick?: Function,
};

export type Actions = {
  edit?: Action,
  delete?: Action,
  join?: Action,
  leave?: Action,
  report?: Action,
  viewers?: string,
};

export type Props = {
  actions: Actions,
  hasStory?: boolean,
  dark?: boolean,
};

const EDIT = 'edit';
const DELETE = 'delete';
const JOIN = 'join';
const LEAVE = 'leave';
const REPORT = 'report';
const VIEWERS = 'viewers';

const classMap = (dark: ?boolean) => {
  const className = dark ? css.actionDark : css.action;
  return {
    edit: <FontAwesomeIcon icon={faPencilAlt} className={className} />,
    delete: <FontAwesomeIcon icon={faTrash} className={className} />,
    join: <FontAwesomeIcon icon={faDoorOpen} className={className} />,
    leave: <FontAwesomeIcon icon={faDoorClosed} className={className} />,
    report: (
      <FontAwesomeIcon icon={faExclamationTriangle} className={className} />
    ),
    viewers: <FontAwesomeIcon icon={faLock} className={className} />,
  };
};

const displayViewers = (
  actions: Actions,
  item: string,
  hasStory: ?boolean,
  dark: ?boolean,
) => (
  <div
    key={item}
    className="storyActionsViewers"
    aria-label={actions[item]}
    role="button"
    tabIndex={0}
  >
    <Tooltip
      className="storyActionsViewer"
      element={classMap(dark)[item]}
      text={actions[item]}
      right={!!hasStory}
    />
  </div>
);

const titleItem = (item: string) => item.charAt(0).toUpperCase() + item.slice(1);

const tooltipElement = (item: string, actions: Actions, dark: ?boolean) => {
  const {
    link, dataMethod, dataConfirm, name, onClick,
  } = actions[item];
  return (
    <a
      href={link}
      data-method={dataMethod}
      data-confirm={dataConfirm}
      aria-label={name}
      onClick={
        onClick
          ? (e: SyntheticEvent<HTMLInputElement>) => onClick(e, link)
          : undefined
      }
    >
      {classMap(dark)[item]}
    </a>
  );
};

const displayLink = (
  actions: Actions,
  item: string,
  hasStory: ?boolean,
  dark: ?boolean,
) => (
  <div
    role="button"
    tabIndex={0}
    key={item}
    aria-label={actions[item]}
    className={`storyActions${titleItem(item)}`}
  >
    <Tooltip
      element={tooltipElement(item, actions, dark)}
      text={actions[item].name}
      right={!!hasStory}
    />
  </div>
);

const displayItem = (
  actions: Actions,
  item: string,
  hasStory: ?boolean,
  dark: ?boolean,
) => {
  if (item === VIEWERS) return displayViewers(actions, item, hasStory, dark);
  return displayLink(actions, item, hasStory, dark);
};

export const StoryActions = (props: Props) => {
  const { actions, hasStory, dark } = props;
  return (
    <div className={css.actions}>
      {[JOIN, EDIT, LEAVE, DELETE, REPORT, VIEWERS].map(
        (item: string) => (actions[item] ? displayItem(actions, item, hasStory, dark) : null),
      )}
    </div>
  );
};
