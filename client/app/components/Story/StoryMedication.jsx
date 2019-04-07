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

const medicDosage = (medicationDosages: Object) => {
  const {
    isDaily,
    dosageDaily,
    dosageWeekly,
    weeklyDosageMap,
  } = medicationDosages;
  if (isDaily) {
    return <strong>{dosageDaily}</strong>;
  }
  return (
    <div>
      <strong>{dosageWeekly}</strong>
      {weeklyDosageMap}
    </div>
  );
};

const displayStrength = (medicationStrength: Object) => {
  const { strength, strengthUnits } = medicationStrength;
  return (
    <div>
      <strong>{strength}</strong>
      {strengthUnits}
    </div>
  );
};

export const StoryMedication = (props: Props) => {
  const {
    medicationStrength,
    quantity,
    totalUnits,
    medicationDosages,
    dosageUnit,
    refill,
    medicationRefill,
  } = props;

  return (
    <div>
      {displayStrength(medicationStrength)}
      <div>
        <strong>{quantity}</strong>
        {totalUnits}
      </div>
      {medicDosage(medicationDosages)}
      {dosageUnit}
      <div>
        <strong>{refill}</strong>
        {medicationRefill}
      </div>
    </div>
  );
};
