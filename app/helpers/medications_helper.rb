# frozen_string_literal: true

module MedicationsHelper
  include DateTimeHelper

  def present_medication(medication)
    {
      name: medication.name,
      link: medication_path(medication),
      actions: {
        edit: edit_action(medication),
        delete: delete_action(medication)
      },
      medicationBody: medication_body(medication)
    }
  end

  private

  def edit_action(medication)
    {
      name: t('common.actions.edit'),
      link: edit_medication_path(medication)
    }
  end

  def delete_action(medication)
    {
      name: t('common.actions.delete'),
      link: medication_path(medication),
      dataConfirm: t('common.actions.confirm'),
      dataMethod: 'delete'
    }
  end

  def medication_body(medication)
    {
      medicationStrength: medication_strength(medication),
      quantity: t('medications.quantity'),
      medicationDosages: medication_dosages(medication),
      refill: t('medications.refill'),
      medicationRefill: format_date(medication.refill)
    }.merge(medication_units(medication))
  end

  def medication_units(medication)
    {
      totalUnits: t('medications.units.display',
                    count: medication.total,
                    unit: medication.total_unit),
      dosageUnit: t('medications.units.display',
                    count: medication.dosage,
                    unit: medication.dosage_unit)
    }
  end

  def medication_strength(medication)
    {
      strength: t('medications.strength'),
      strengthUnits: t('medications.units.display',
                       count: medication.strength,
                       unit: medication.strength_unit)
    }
  end

  def medication_dosages(medication)
    {
      isDaily: medication.daily?,
      dosageDaily: t('medications.dosage'),
      dosageWeekly: t('medications.weekly_dosage'),
      weeklyDosageMap: weekly_dosage(medication)
    }
  end

  def weekly_dosage(medication)
    medication.weekly_dosage.map { |i| t(:'date.abbr_day_names')[i] }.join(', ')
  end
end
