// @flow
import { render } from 'enzyme';
import React from 'react';
import { MomentCard } from '../index';

describe('MomentCard', () => {
  it('renders a MomentCard', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <MomentCard
          action={{
            edit: () => {},
            delete: () => {},
            viewer: () => {},
          }}
          item={{
            name: 'Real Moment',
            category: ['FRIENDS', 'FAMILY'],
            mood: ['ANXIOUS', 'HELPFUL'],
          }}
          date="Created 2 Days ago"
          cardType="Normal"
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });

  it('renders a MomentCard Example', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <MomentCard
          action={{
            viewer: () => {},
          }}
          item={{
            name: 'Example Moment: Panicking over interview tomorrow!',
            category: ['CAREER'],
            mood: ['NERVOUS', 'ANXIOUS', 'HELPFUL'],
          }}
          date=""
          cardType="Example"
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });

  it('renders a MomentCard Draft', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <MomentCard
          action={{
            edit: () => {},
            delete: () => {},
            viewer: () => {},
          }}
          item={{
            name: 'Real Moment',
            category: ['FRIENDS', 'FAMILY'],
            mood: ['ANXIOUS', 'HELPFUL'],
          }}
          date=""
          cardType="Draft"
          draftText="DRAFT"
        />,
      );
    }).not.toThrow();

    expect(wrapper).not.toBeNull();
  });
});
