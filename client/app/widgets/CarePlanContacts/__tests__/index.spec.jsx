import { render, mount } from 'enzyme';
import React from 'react';
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
});
