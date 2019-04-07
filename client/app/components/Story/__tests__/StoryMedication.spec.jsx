// @flow
import { render } from 'enzyme';
import React from 'react';
import { StoryMedication } from '../StoryMedication';

describe('StoryMedication', () => {
  it('renders correctly', () => {
    let wrapper = null;
    expect(() => {
      wrapper = render(
        <StoryMedication
          medicationStrength={{
            strength: 'strength',
            strengthUnits: 'strengthUnits',
          }}
          quantity="quantity"
          totalUnits="totalUnits"
          medicationDosages={{
            isDaily: true,
            dosageDaily: 'dosageDaily',
            dosageWeekly: 'dosageWeekly',
            weeklyDosageMap: 'weeklyDosageMap',
          }}
          dosageUnit="dosageUnit"
          refill="refill"
        />,
      );
    }).not.toThrow();
    expect(wrapper).not.toBeNull();
  });
});
