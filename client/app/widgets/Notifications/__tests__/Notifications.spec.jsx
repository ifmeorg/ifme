// @flow
import React from 'react';
import axios from 'axios';
import { mount } from 'enzyme';
import { Notifications } from '../index'
import { faItalic } from '@fortawesome/free-solid-svg-icons';

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

  it('gets notifications', async () => {
    const wrapper = mount(component);
    const instance = wrapper.instance();
    instance.setState({ signedInKey: 1 })
    instance.fetchNotifications()
      .then(async () => {
        await axiosGetSpy()
        wrapper.update();
        expect(wrapper.state('notifications')).toBe('<div>Notification 1</div>')
      });
  })
})