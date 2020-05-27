# frozen_string_literal: true
class CarePlanController < ApplicationController
  def index
    @bookmarked_strategies = current_user.strategies.where(bookmarked: true)
  end
end
