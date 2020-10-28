// @flow
import { render, screen } from '@testing-library/react';
import React from 'react';
import { StoryMedication } from 'components/Story/StoryMedication';

describe('StoryMedication', () => {
  const { getByText } = screen;

  it('renders correctly', () => {
    render(
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
    expect(getByText('strength')).toBeInTheDocument();
    expect(getByText('strengthUnits')).toBeInTheDocument();
    expect(getByText('quantity')).toBeInTheDocument();
    expect(getByText('totalUnits')).toBeInTheDocument();
    expect(getByText('dosageDaily')).toBeInTheDocument();
    expect(getByText('dosageUnit')).toBeInTheDocument();
    expect(getByText('refill')).toBeInTheDocument();
  });
});
