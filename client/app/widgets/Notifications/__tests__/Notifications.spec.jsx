// @flow
import React from 'react';
import axios from 'axios';
import { mount } from 'enzyme';
import { Notifications } from '../index'
import { faItalic } from '@fortawesome/free-solid-svg-icons';

let axiosGetSpy;
let axiosDeleteSpy;

const notification = [
  "Notification 1",
  "Notification 2"
]

const notificationsElement = (notifications) => (
  <button type="button" className="buttonGhostXS" aria-label={notifications}>
    "Placeholder"
  </button>
);

const component = <Notifications
                    element={notificationsElement("Notifications")}
                    plural="Notifications"
                    none="There are none"
                    clear="Clear" 
                  />;

describe('Notifications', () => {
  beforeEach(() => {
    axiosGetSpy = jest.spyOn(axios, 'get').mockImplementation(() => Promise.resolve({
      data: { notification }
    }));
    axiosDeleteSpy = jest.spyOn(axios, 'delete').mockImplementation(() => Promise.resolve({
      data: {ok: true}
    }));
  });

  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = mount(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });  
})