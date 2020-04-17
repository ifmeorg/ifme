# frozen_string_literal: true
#
class Task < ApplicationRecord
  has_many :todo_items
end
