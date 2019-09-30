// @flow
import React from 'react';
import axios from 'axios';
import { mount } from 'enzyme';
import { Notifications } from '../index'

let axiosGetSpy;
let axiosDeleteSpy;
let componentDidMountSpy;

const data = {
  signed_in: 1,
  fetch_notifications: ['Notification 1'],
}

const component = <Notifications
                    element={<button>"Notifications"</button>}
                    plural="Notifications"
                    none="There are none"
                    clear="Clear" 
                  />;

describe('Notifications', () => {
  beforeEach(() => {
    axiosGetSpy = jest.spyOn(axios, 'get').mockImplementation(() => Promise.resolve({
      data
    }));
    axiosDeleteSpy = jest.spyOn(axios, 'delete').mockImplementation(() => Promise.resolve({
      data: {ok: true}
    }));
    componentDidMountSpy = jest.spyOn(Notifications.prototype, 'componentDidMount').mockImplementation(() => {})
  });

  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = mount(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });

  it('gets notifications and clears them', async (done) => {
    const wrapper = mount(component);
    const instance = wrapper.instance();
    instance.setState({ signedInKey: 1 });
    instance.fetchNotifications()
      .then(() => {
        wrapper.update();
        expect(wrapper.state('notifications')).toBe('<div>Notification 1</div>');
      })
      .then(async () => {
        await wrapper.find('.buttonDarkS').simulate('click');
        wrapper.update();
        expect(wrapper.find('.modal').exists()).toEqual(false);
      })
      .then(async () => {
        data.fetch_notifications = [];
        await instance.fetchNotifications();
        wrapper.update();
        expect(wrapper.state('notifications')).toBe('');
        done();
      })
      .catch(done);
  })
})