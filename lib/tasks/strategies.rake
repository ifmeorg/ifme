# frozen_string_literal: true

namespace :strategies do
  desc 'TODO'
  task update: :environment do
    @tasks = Task.all
    @tasks.each do |t|
      t.no_of_days_followed += 1 if t.finished
      t.total_no_of_days = (Time.zone.today - t.created_at.to_date).to_i + 1
      t.save
    end
  end
end
