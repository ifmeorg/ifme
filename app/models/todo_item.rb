# frozen_string_literal: true
#
class TodoItem < ApplicationRecord
  belongs_to :task
end
