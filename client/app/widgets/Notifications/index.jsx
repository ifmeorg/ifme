// @flow
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import renderHTML from 'react-render-html';
import Modal from '../../components/Modal';
import { Utils } from '../../utils';
import { I18n } from '../../libs/i18n/index';

export type Props = {
  element: any,
};

export type State = {
  notifications: string,
  alreadyMounted: boolean,
  open: boolean,
  modalKey?: string,
  signedInKey?: number,
};

export const Notifications = ({
  element,
}: Props) => {
  const [notifications, setnotifications] = useState('');
  const [alreadyMounted, setalreadyMounted] = useState(false);
  const [open, setopen] = useState(false);
  const [signedInKey, setsignedInKey] = useState();
  const [modalKey, setmodalKey] = useState();

  const setBody = (paramsNotifications: string[]) => {
    let updatedNotifications = '';
    paramsNotifications.forEach((item: string) => {
      updatedNotifications += `<div>${item}</div>`;
    });
    setnotifications(updatedNotifications);
  };

  const changeTitle = (count: number) => {
    let { title } = window.document;
    const eliminate = `${title.substr(0, title.indexOf(') '))})`;
    title = title.replace(eliminate, '');
    window.document.title = count === 0 ? title : `(${count}) ${title}`;
  };

  let fetchNotifications;

  const getPusherKey = (paramSignedInKey: number) => {
    setsignedInKey(paramSignedInKey);
    const metaPusherKey = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter((item) => item.getAttribute('name') === 'pusher-key')[0];
    const pusherKey = metaPusherKey.getAttribute('content');
    const pusher = new window.Pusher(pusherKey, { encrypted: true });
    const channel = pusher.subscribe(`private-${signedInKey}`);
    channel.bind('new_notification', (response: any) => {
      if (response && response.data) {
        fetchNotifications();
      }
    });
  };

  fetchNotifications = () => {
    const { alreadyMounted, signedInKey } = this.state;
    Utils.setCsrfToken();
    return axios
      .get('/notifications/signed_in')
      .then((response: any) => {
        if (response && response.data && response.data.signed_in !== -1) {
          if (response.data.signed_in !== signedInKey) {
            this.getPusherKey(response.data.signed_in);
          }
          return axios.get('/notifications/fetch_notifications');
        }
      }
      return -1;
    })
    .then((response: any) => {
      if (response && response.data && response.data.fetch_notifications) {
        changeTitle(response.data.fetch_notifications.length);
        setBody(response.data.fetch_notifications);
        if (!alreadyMounted && response.data.fetch_notifications.length > 0) {
          setalreadyMounted(true);
          setopen(true);
          setmodalKey(Utils.randomString());
        }
      }
    });

  const clearNotifications = () => {
    axios.delete('/notifications/clear').then((response: any) => {
      if (response) {
        changeTitle(0);
        setopen(false);
        setmodalKey(Utils.randomString());
        fetchNotifications();
      }
    });
  };

  const displayNotifications = () => (
    <div aria-live="polite">
      {renderHTML(notifications)}
      <button
        type="button"
        className="buttonDarkS smallMarginTop"
        onClick={clearNotifications}
      >
        {I18n.t('notifications.clear')}
      </button>
    </div>
  );

  useEffect(() => {
    fetchNotifications();
  }, []);

  return (
    <Modal
      element={element}
      elementId="notificationsElement"
      title={I18n.t('notifications.plural')}
      body={
        notifications.length
          ? displayNotifications()
          : I18n.t('notifications.none')
      }
      openListener={fetchNotifications}
      open={open}
      modalKey={modalKey}
    />
  );
};

// There's a [bug](https://github.com/shakacode/react_on_rails/issues/1198) with React on Rails,
// so we'll need to do this in order to render multiple components with hooks on the same page.
export default ({
  element,
}: Props) => (
  <Notifications
    element={element}
  />
);
