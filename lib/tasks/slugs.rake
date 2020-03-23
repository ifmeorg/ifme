# frozen_string_literal: true

namespace :slugs do
  desc 'Add slugs to models'
  task slugify: :environment do
    Moment.find_each(&:save)
    Strategy.find_each(&:save)
    Mood.find_each(&:save)
    Category.find_each(&:save)
    Medication.find_each(&:save)
    Group.find_each(&:save)
    Meeting.find_each(&:save)
  end
end
