// @flow
import React from 'react';
import axios from 'axios';
import renderHTML from 'react-render-html';
import { Modal } from '../../components/Modal';

export interface Props {
  element: any;
  plural: string;
  none: string;
  clear: string;
}

export interface State {
  notifications: string;
  alreadyMounted: boolean;
}

export class Notifications extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { notifications: '', alreadyMounted: false };
  }

  componentWillMount() {
    this.fetchNotifications();
  }

  changeTitle = (count: number) => {
    let title = window.document.title;
    const eliminate = `${title.substr(0, title.indexOf(') '))})`;
    title = title.replace(eliminate, '');
    window.document.title = count === 0 ? title : `(${count}) ${title}`;
  };

  getPusherKey = (signedIn: number) => {
    const metaPusherKey = Array.from(
      window.document.getElementsByTagName('meta'),
    ).filter(item => item.getAttribute('name') === 'pusher-key')[0];
    const pusherKey = metaPusherKey.getAttribute('content');
    const pusher = new window.Pusher(pusherKey, { encrypted: true });
    const channel = pusher.subscribe(`private-${signedIn}`);
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
    const { alreadyMounted } = this.state;
    axios
      .get('/notifications/signed_in')
      .then((response: any) => {
        if (response && response.data && response.data.signed_in !== -1) {
          this.getPusherKey(response.data.signed_in);
          return axios.get('/notifications/fetch_notifications');
        }
        return -1;
      })
      .then((response: any) => {
        if (response && response.data && response.data.fetch_notifications) {
          this.changeTitle(response.data.fetch_notifications.length);
          this.setBody(response.data.fetch_notifications);
          if (!alreadyMounted && response.data.fetch_notifications.length > 0) {
            this.setState({ alreadyMounted: true });
            window.document.getElementById('notificationsElement').click();
          }
        }
      });
  };

  clearNotifications = () => {
    axios.delete('/notifications/clear').then((response: any) => {
      if (response) {
        this.changeTitle(0);
        window.document.getElementById('modalClose').click();
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
          className="buttonDarkS small_margin_top"
          onClick={() => this.clearNotifications()}
        >
          {clear}
        </button>
      </div>
    );
  };

  render() {
    const { element, plural, none } = this.props;
    const { notifications } = this.state;
    return (
      <Modal
        element={element}
        elementId="notificationsElement"
        title={plural}
        body={notifications.length ? this.displayNotifications() : none}
        openListener={() => this.fetchNotifications()}
      />
    );
  }
}
