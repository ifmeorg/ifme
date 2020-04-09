// @flow
import React, { useState } from 'react';
import axios from 'axios';
import renderHTML from 'react-render-html';
import { Modal } from '../../components/Modal';
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

const Notifications = ({
  element,
}: Props) => {
  const [notifications, setNotifications] = useState('');
  const [alreadyMounted, setAlreadyMounted] = useState(false);
  const [open, setOpen] = useState(false);
  const [modalKey, setModalKey] = useState('');
  const [signedInKey, setSignedInKey] = useState(0);

  useEffect(() => fetchNotifications(), []);

  const changeTitle = (count: number) => {
    let { title } = window.document;
    const eliminate = `${title.substr(0, title.indexOf(') '))})`;
    title = title.replace(eliminate, '');
    window.document.title = count === 0 ? title : `(${count}) ${title}`;
  };

  const getPusherKey = (signedInKey: number) => {
    setSignedInKey(signedInKey);
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

  const setBody = (notifications: string[]) => {
    let updatedNotifications = '';
    notifications.forEach((item: string) => {
      updatedNotifications += `<div>${item}</div>`;
    });
    setNotifications(updatedNotifications);
  };

  const fetchNotifications = () => {
    setAlreadyMounted(alreadyMounted);
    setSignedInKey(signedInKey);
    return axios
      .get('/notifications/signed_in')
      .then((response: any) => {
        if (response && response.data && response.data.signed_in !== -1) {
          if (response.data.signed_in !== signedInKey) {
            getPusherKey(response.data.signed_in);
          }
          return axios.get('/notifications/fetch_notifications');
        }
        return -1;
      })
      .then((response: any) => {
        if (response && response.data && response.data.fetch_notifications) {
          changeTitle(response.data.fetch_notifications.length);
          setBody(response.data.fetch_notifications);
          if (!alreadyMounted && response.data.fetch_notifications.length > 0) {
            setAlreadyMounted(true);
            setOpen(true);
            setModalKey(Utils.randomString());
            }
          }
      });
  };

  const clearNotifications = () => {
    axios.delete('/notifications/clear').then((response: any) => {
      if (response) {
        changeTitle(0);
        setOpen(false);
        setModalKey(Utils.randomString());
        fetchNotifications();
      }
    });
  };

  const displayNotifications = () => {
    setNotifications(notifications);
    return (
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
  };

  export default ({
  element,
  }: Props) => (
  <Notifications element={element} />
  );
}
