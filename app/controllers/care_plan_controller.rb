# frozen_string_literal: true
class CarePlanController < ApplicationController
  def index
    @bookmarked_strategies = current_user.strategies.where(bookmarked: true)
    @contacts = current_user.care_plan_contacts.order(name: :desc)
  end
end
