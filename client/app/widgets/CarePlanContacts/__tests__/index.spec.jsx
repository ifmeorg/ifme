import React from 'react';
import axios from 'axios';
import { render, mount } from 'enzyme';
import CarePlanContacts from '../index';

const contacts = [
  {
    id: 1,
    name: 'Test1 Lastname',
  },
  {
    id: 2,
    name: 'Test2 Lastname',
    phone: '4161234567'
  }
];

const component = <CarePlanContacts contacts={contacts} />;

describe('CarePlanContacts', () => {
  it('renders the component', () => {
    let wrapper;
    expect(() => {
      wrapper = render(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
    expect(wrapper.text()).toContain('Test1 Lastname');
    expect(wrapper.text()).toContain('Test2 Lastname');
  });

  describe('when editing a contact', () => {
    it('opens a modal and submits the form', async () => {
      const axiosPatchSpy = jest.spyOn(axios, 'patch').mockImplementation(() => Promise.resolve({
        data: {
          id: 1,
          name: 'Test1 Lastname',
          phone: '4160000000',
          success: true,
        },
      }));
      jest.spyOn(window.location, 'reload');
      const wrapper = mount(component);
      const edit = wrapper.find('a[aria-label="Edit"]').at(0);
      edit.simulate('click');
      expect(wrapper.text()).toContain('Edit Contact');
      expect(wrapper.find('input[aria-label="Name"]').props().defaultValue).toEqual('Test1 Lastname');
      expect(wrapper.find('input[aria-label="Phone number"]').props().defaultValue).toEqual(undefined);
      wrapper
        .find('input[aria-label="Phone number"]')
        .simulate('change', { currentTarget: { value: '4160000000' } });
      wrapper.find('input[type="submit"]').simulate('click');
      await axiosPatchSpy();
      expect(window.location.reload).toHaveBeenCalled();
    });
  });

  describe('when creating a contact', () => {
    it('opens a modal and submits the form', async () => {
      const axiosPostSpy = jest.spyOn(axios, 'post').mockImplementation(() => Promise.resolve({
        data: {
          id: 1,
          name: 'Test3 Lastname',
          phone: '4160000000',
          success: true,
        },
      }));
      jest.spyOn(window.location, 'reload');
      const wrapper = mount(component);
      const newContact = wrapper.find('button[children="New Contact"]');
      newContact.simulate('click');
      expect(wrapper.text()).toContain('New Contact');
      wrapper
        .find('input[aria-label="Name"]')
        .simulate('change', { currentTarget: { value: 'Test3 Lastname' } });
      wrapper
        .find('input[aria-label="Phone number"]')
        .simulate('change', { currentTarget: { value: '4160000000' } });
      wrapper.find('input[type="submit"]').simulate('click');
      await axiosPostSpy();
      expect(window.location.reload).toHaveBeenCalled();
    });
  });
});
