# frozen_string_literal: true

class AddCrisisPreventionAcknowledgedToMoments < ActiveRecord::Migration[7.0]
  def change
    add_column :moments, :crisis_prevention_acknowledged, :boolean,
               default: false, null: false
    add_column :moments, :crisis_prevention_acknowledged_text, :text
  end
end
