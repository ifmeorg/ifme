# frozen_string_literal: true
module CarePlanContactsConcern
  extend ActiveSupport::Concern

  def create_response_object(care_plan_contact)
    return { success: false } unless care_plan_contact.save

    { success: true, id: care_plan_contact.id,
      name: care_plan_contact.name, phone: care_plan_contact.phone }
  end

  def update_response_object(care_plan_contact)
    unless care_plan_contact.update(care_plan_contact_params)
      return { success: false }
    end

    { success: true, id: care_plan_contact.id,
      name: care_plan_contact.name, phone: care_plan_contact.phone }
  end
end
