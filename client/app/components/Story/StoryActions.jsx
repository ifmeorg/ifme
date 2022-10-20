// @flow
import React from 'react';
import type { Node } from 'react';
import { I18n } from 'libs/i18n';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faPencilAlt,
  faTrash,
  faLock,
  faDoorOpen,
  faDoorClosed,
  faExclamationTriangle,
  faEyeSlash,
  faCalendarPlus,
  faCalendarMinus,
  faChartLine,
  faKey,
} from '@fortawesome/free-solid-svg-icons';
import { Tooltip } from 'components/Tooltip';
import css from './Story.scss';

export type Action = {
  name: string,
  link?: string,
  dataMethod?: string,
  dataConfirm?: string,
  onClick?: Function,
  commentBy?: string,
};

export type Actions = {
  edit?: Action,
  delete?: Action,
  join?: Action,
  leave?: Action,
  report?: Action,
  add_to_google_cal?: Action,
  remove_from_google_cal?: Action,
  viewers?: string,
  visible?: string,
  not_visible?: string,
};

export type Props = {
  actions: Actions,
  storyName?: string,
  hasStory?: boolean,
  dark?: boolean,
};

const EDIT = 'edit';
const DELETE = 'delete';
const JOIN = 'join';
const LEAVE = 'leave';
const REPORT = 'report';
const VIEWERS = 'viewers';
const VISIBLE = 'visible';
const NOT_VISIBLE = 'not_visible';
const ADD_TO_G_CAL = 'add_to_google_cal';
const REMOVE_FROM_G_CAL = 'remove_from_google_cal';
const SHARE_LINK_INFO = 'share_link_info';

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
    viewers: (
      <FontAwesomeIcon
        icon={faLock}
        className={className}
        tabIndex={0}
        aria-label={I18n.t('shared.viewers.plural')}
      />
    ),
    visible: (
      <FontAwesomeIcon
        icon={faChartLine}
        className={className}
        tabIndex={0}
        aria-label={I18n.t('shared.stats.visible_in_stats')}
      />
    ),
    not_visible: (
      <FontAwesomeIcon
        icon={faEyeSlash}
        className={className}
        tabIndex={0}
        aria-label={I18n.t('shared.stats.not_visible_in_stats')}
      />
    ),
    add_to_google_cal: (
      <FontAwesomeIcon icon={faCalendarPlus} className={className} />
    ),
    remove_from_google_cal: (
      <FontAwesomeIcon icon={faCalendarMinus} className={className} />
    ),
    share_link_info: <FontAwesomeIcon icon={faKey} className={className} />,
  };
};

const displayNonLink = (
  actions: Actions,
  item: string,
  hasStory: ?boolean,
  dark: ?boolean,
) => {
  const capitalizeItem = item.charAt(0).toUpperCase() + item.slice(1);
  return (
    <div key={item} className={`storyActions${capitalizeItem}`}>
      <Tooltip
        element={classMap(dark)[item]}
        text={actions[item]}
        right={!!hasStory}
      />
    </div>
  );
};

const titleItem = (item: string) => item.charAt(0).toUpperCase() + item.slice(1);

const tooltipElement = (
  item: string,
  actions: Actions,
  storyName: ?string,
  dark: ?boolean,
) => {
  const {
    link, dataMethod, dataConfirm, name, onClick, commentBy,
  } = actions[item];

  const ariaLabel = commentBy || `${name} ${storyName || ''}`;

  return (
    <a
      href={link}
      data-method={dataMethod}
      data-confirm={dataConfirm}
      aria-label={ariaLabel}
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
  storyName: ?string,
  hasStory: ?boolean,
  dark: ?boolean,
) => (
  <div key={item} className={`storyActions${titleItem(item)}`}>
    <Tooltip
      element={tooltipElement(item, actions, storyName, dark)}
      text={actions[item].name}
      right={!!hasStory}
    />
  </div>
);

const displayItem = (
  actions: Actions,
  item: string,
  storyName: ?string,
  hasStory: ?boolean,
  dark: ?boolean,
) => {
  if (
    item === VIEWERS
    || item === VISIBLE
    || item === NOT_VISIBLE
    || item === SHARE_LINK_INFO
  ) {
    return displayNonLink(actions, item, hasStory, dark);
  }
  return displayLink(actions, item, storyName, hasStory, dark);
};

export const StoryActions = (props: Props): Node => {
  const {
    actions, hasStory, dark, storyName,
  } = props;
  return (
    <div className={css.actions}>
      {[
        JOIN,
        ADD_TO_G_CAL,
        REMOVE_FROM_G_CAL,
        EDIT,
        LEAVE,
        DELETE,
        REPORT,
        VISIBLE,
        NOT_VISIBLE,
        VIEWERS,
        SHARE_LINK_INFO,
      ].map((item: string) => (actions[item]
        ? displayItem(actions, item, storyName, hasStory, dark)
        : null))}
    </div>
  );
};
