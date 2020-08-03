import React from 'react';
import axios from 'axios';
import { render, mount } from 'enzyme';
import { act } from 'react-dom/test-utils';
import CarePlanContacts from '../index';

const contacts = [
  {
    id: 1,
    name: 'Test1 Lastname',
  },
  {
    id: 2,
    name: 'Test2 Lastname',
    phone: '4161234567',
  },
];

const component = <CarePlanContacts contacts={contacts} />;
const error = new Error('Error');

describe('CarePlanContacts', () => {
  afterEach(() => {
    jest.restoreAllMocks();
  });

  it('renders the component', () => {
    let wrapper;
    expect(() => {
      wrapper = render(component);
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });

  describe('when editing a contact', () => {
    it('opens a modal and submits the form successfully', async () => {
      const axiosPatchSpy = jest.spyOn(axios, 'patch').mockImplementation(() => Promise.resolve({
        data: {
          id: 1,
          name: 'Test1 Lastname',
          phone: '4160000000',
        },
      }));
      const wrapper = mount(component);
      wrapper
        .find('a[aria-label="Edit"]')
        .at(0)
        .simulate('click');
      expect(wrapper.text()).toContain('Edit Contact');
      expect(
        wrapper.find('input[aria-label="Name"]').props().defaultValue,
      ).toEqual('Test1 Lastname');
      expect(
        wrapper.find('input[aria-label="Phone number"]').props().defaultValue,
      ).toEqual(undefined);
      wrapper.find('input[aria-label="Phone number"]').instance().value = '4160000000';
      await act(async () => {
        await wrapper.find('input[type="submit"]').simulate('click');
      });
      axiosPatchSpy();
      expect(wrapper.text()).toContain('4160000000');
    });

    it('opens a modal and does not submit the form successfully', async () => {
      const axiosPatchSpy = jest
        .spyOn(axios, 'patch')
        .mockImplementation(() => Promise.reject(error));
      const wrapper = mount(component);
      wrapper
        .find('a[aria-label="Edit"]')
        .at(0)
        .simulate('click');
      expect(wrapper.text()).toContain('Edit Contact');
      expect(
        wrapper.find('input[aria-label="Name"]').props().defaultValue,
      ).toEqual('Test1 Lastname');
      expect(
        wrapper.find('input[aria-label="Phone number"]').props().defaultValue,
      ).toEqual(undefined);
      wrapper.find('input[aria-label="Phone number"]').instance().value = '4160000000';
      await act(async () => {
        await wrapper.find('input[type="submit"]').simulate('click');
      });
      expect(axiosPatchSpy()).rejects.toEqual(error);
      expect(wrapper.text()).toContain('Error');
    });
  });

  describe('when creating a contact', () => {
    it('opens a modal and submits the form successfully', async () => {
      const axiosPostSpy = jest.spyOn(axios, 'post').mockImplementation(() => Promise.resolve({
        data: {
          id: 1,
          name: 'Test3 Lastname',
          phone: '4160000000',
        },
      }));
      const wrapper = mount(<CarePlanContacts />);
      wrapper.find('button[children="New Contact"]').simulate('click');
      expect(wrapper.text()).toContain('New Contact');
      wrapper.find('input[aria-label="Name"]').instance().value = 'Test3 Lastname';
      wrapper.find('input[aria-label="Phone number"]').instance().value = '4160000000';
      await act(async () => {
        await wrapper.find('input[type="submit"]').simulate('click');
      });
      axiosPostSpy();
      expect(wrapper.text()).toContain('Test3 Lastname');
      expect(wrapper.text()).toContain('4160000000');
    });

    it('opens a modal and does not submit the form successfully', async () => {
      const axiosPostSpy = jest
        .spyOn(axios, 'post')
        .mockImplementation(() => Promise.reject(error));
      const wrapper = mount(<CarePlanContacts />);
      wrapper.find('button[children="New Contact"]').simulate('click');
      expect(wrapper.text()).toContain('New Contact');
      wrapper.find('input[aria-label="Name"]').instance().value = 'Test3 Lastname';
      wrapper.find('input[aria-label="Phone number"]').instance().value = '4160000000';
      await act(async () => {
        await wrapper.find('input[type="submit"]').simulate('click');
      });
      expect(axiosPostSpy()).rejects.toEqual(error);
      expect(wrapper.text()).toContain('Error');
    });
  });
});
