// @flow
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import renderHTML from 'react-render-html';
import { I18n } from 'libs/i18n';
import Modal from 'components/Modal';
import { Utils } from 'utils';

export type Props = {
  element: any,
  pusher?: Object,
};

export type State = {
  notifications: string,
  alreadyMounted: boolean,
  open: boolean,
  modalKey?: string,
};

export const Notifications = ({ element, pusher }: Props) => {
  const [notifications, setNotifications] = useState('');
  const [alreadyMounted, setAlreadyMounted] = useState(false);
  const [open, setOpen] = useState(false);
  const [modalKey, setModalKey] = useState();

  const setBody = (paramsNotifications: string[]) => {
    let updatedNotifications = '';
    paramsNotifications.forEach((item: string) => {
      updatedNotifications += `<div>${item}</div>`;
    });
    setNotifications(updatedNotifications);
  };

  const changeTitle = (count: number) => {
    let { title } = window.document;
    const eliminate = `${title.substr(0, title.indexOf(') '))})`;
    title = title.replace(eliminate, '');
    window.document.title = count === 0 ? title : `(${count}) ${title}`;
  };

  const fetchNotifications = () => axios.get('/notifications/fetch_notifications').then((response: any) => {
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

  const fetchData = () => {
    Utils.setCsrfToken();
    return axios.get('/notifications/signed_in').then((response: any) => {
      if (response && response.data && !!response.data.signed_in) {
        if (pusher) {
          const channel = pusher.subscribe(
            `private-${response.data.signed_in}`,
          );
          channel.bind('new_notification', () => {
            fetchNotifications();
          });
        }
        fetchNotifications();
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
    fetchData();
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

export default ({ element, pusher }: Props) => (
  <Notifications element={element} pusher={pusher} />
);
