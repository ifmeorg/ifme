// @flow
import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faPencilAlt,
  faTrash,
  faLock,
} from '@fortawesome/free-solid-svg-icons';
import css from './Story.scss';

export interface Props {
  link: string;
  actions: {
    edit?: string,
    delete?: string,
    viewers?: string,
  };
}

const classMap = {
  edit: <FontAwesomeIcon icon={faPencilAlt} className={css.action} />,
  delete: <FontAwesomeIcon icon={faTrash} className={css.action} />,
  viewers: <FontAwesomeIcon icon={faLock} className={css.action} />,
};

const getHref = (props: Props, item: string) => {
  const { actions, link } = props;
  if (item === 'edit') {
    return actions[item];
  } else if (item === 'delete') {
    return link;
  }
  return null;
};

export const StoryActions = (props: Props) => {
  const { actions } = props;
  return (
    <div className={css.actions}>
      {['edit', 'delete', 'viewers'].map((item: string) => {
        if (actions && actions[item]) {
          return (
            <a
              href={getHref(props, item)}
              data-method={item === 'delete' ? 'delete' : ''}
              data-confirm={item === 'delete' ? actions[item] : null}
            >
              {classMap[item]}
            </a>
          );
        }
        return null;
      })}
    </div>
  );
};
