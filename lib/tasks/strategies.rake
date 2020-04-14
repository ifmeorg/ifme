namespace :strategies do
  desc "TODO"
  task update: :environment do
    @tasks = Task.all()
    @tasks.each do |t|
      if t.finished
        t.no_of_days_followed += 1
      end
      t.total_no_of_days = (Date.today - t.created_at.to_date).to_i + 1
    t.save
    end
  end

end
