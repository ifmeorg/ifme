// @flow
import React from 'react';

export type Props = {
  medicationStrength: Object,
  quantity: string,
  totalUnits: string,
  medicationDosages: Object,
  dosageUnit: string,
  refill: string,
  medicationRefill?: string,
};

const medicDosage = ({
  isDaily,
  dosageDaily,
  dosageWeekly,
  weeklyDosageMap,
}: Object) => {
  if (isDaily) {
    return <strong>{dosageDaily}</strong>;
  }
  return (
    <div>
      <strong>{dosageWeekly}</strong>
      {' '}
      {weeklyDosageMap}
    </div>
  );
};

const displayStrength = ({ strength, strengthUnits }: Object) => (
  <div>
    <strong>{strength}</strong>
    {' '}
    {strengthUnits}
  </div>
);

export const StoryMedication = ({
  medicationStrength,
  quantity,
  totalUnits,
  medicationDosages,
  dosageUnit,
  refill,
  medicationRefill,
}: Props) => (
  <div>
    {displayStrength(medicationStrength)}
    <div>
      <strong>{quantity}</strong>
      {' '}
      {totalUnits}
    </div>
    {medicDosage(medicationDosages)}
    {' '}
    {dosageUnit}
    <div>
      <strong>{refill}</strong>
      {' '}
      {medicationRefill}
    </div>
  </div>
);
