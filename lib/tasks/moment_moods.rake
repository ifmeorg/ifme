namespace :moment_moods do
  desc "Migrates moods from moments to moment_moods table"

  task normalize: :environment do
    Moment.all.each do |moment|
      moment.mood.each do |mood_id|
        moment.moment_moods.create(mood_id: mood_id)
      end
    end
  end
end
