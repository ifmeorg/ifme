// @flow
import React from 'react';
import axios from 'axios';
import renderHTML from 'react-render-html';
import { Modal } from '../../components/Modal';
import { Utils } from '../../utils';

export type Props = {
  element: any,
  plural: string,
  none: string,
  clear: string,
};

export type State = {
  notifications: string,
  alreadyMounted: boolean,
  open: boolean,
  modalKey?: string,
  signedInKey?: number,
};

export class Notifications extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { notifications: '', alreadyMounted: false, open: false };
  }

  componentWillMount() {
    this.fetchNotifications();
  }

  changeTitle = (count: number) => {
    let { title } = window.document;
    const eliminate = `${title.substr(0, title.indexOf(') '))})`;
    title = title.replace(eliminate, '');
    window.document.title = count === 0 ? title : `(${count}) ${title}`;
  };

  getPusherKey = (signedInKey: number) => {
    this.setState({ signedInKey });
    const metaPusherKey = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter(item => item.getAttribute('name') === 'pusher-key')[0];
    const pusherKey = metaPusherKey.getAttribute('content');
    const pusher = new window.Pusher(pusherKey, { encrypted: true });
    const channel = pusher.subscribe(`private-${signedInKey}`);
    channel.bind('new_notification', (response: any) => {
      if (response && response.data) {
        this.fetchNotifications();
      }
    });
  };

  setBody = (notifications: string[]) => {
    let updatedNotifications = '';
    notifications.forEach((item: string) => {
      updatedNotifications += `<div>${item}</div>`;
    });
    this.setState({ notifications: updatedNotifications });
  };

  fetchNotifications = () => {
    const { alreadyMounted, signedInKey } = this.state;
    axios
      .get('/notifications/signed_in')
      .then((response: any) => {
        if (response && response.data && response.data.signed_in !== -1) {
          if (response.data.signed_in !== signedInKey) {
            this.getPusherKey(response.data.signed_in);
          }
          return axios.get('/notifications/fetch_notifications');
        }
        return -1;
      })
      .then((response: any) => {
        if (response && response.data && response.data.fetch_notifications) {
          this.changeTitle(response.data.fetch_notifications.length);
          this.setBody(response.data.fetch_notifications);
          if (!alreadyMounted && response.data.fetch_notifications.length > 0) {
            this.setState({
              alreadyMounted: true,
              open: true,
              modalKey: Utils.randomString(),
            });
          }
        }
      });
  };

  clearNotifications = () => {
    axios.delete('/notifications/clear').then((response: any) => {
      if (response) {
        this.changeTitle(0);
        this.setState({ open: false, modalKey: Utils.randomString() });
        this.fetchNotifications();
      }
    });
  };

  displayNotifications = () => {
    const { clear } = this.props;
    const { notifications } = this.state;
    return (
      <div>
        {renderHTML(notifications)}
        <button
          type="button"
          className="buttonDarkS smallMarginTop"
          onClick={this.clearNotifications}
        >
          {clear}
        </button>
      </div>
    );
  };

  render() {
    const { element, plural, none } = this.props;
    const { notifications, open, modalKey } = this.state;
    return (
      <Modal
        element={element}
        elementId="notificationsElement"
        title={plural}
        body={notifications.length ? this.displayNotifications() : none}
        openListener={this.fetchNotifications}
        open={open}
        key={modalKey}
      />
    );
  }
}
