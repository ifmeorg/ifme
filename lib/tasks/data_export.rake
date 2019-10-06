namespace :data_export do
  desc 'TODO'
  task Add: :environment do
    require 'csv'
    User.where(export_request: true).each do |user|

      folder_name = "app/assets/export/user_#{user.id}_data"
      # Dir.mkdir(folder_name) unless File.exists?(folder_name)
      Dir.mkdir(folder_name) unless File.exist?(folder_name)


      # Groups
      user.groups.each do |group|
        # Group info
        CSV.open("#{folder_name}/group_data.csv", 'wb') do |csv|
          attributes = %w[id name description created_at]
          csv << attributes
          user.groups.each do |group|
            csv << attributes.map { |attr| group.send(attr) }
          end
        end

        # Meeting info
        CSV.open("#{folder_name}/group_#{group.name}_meeting_data.csv", 'wb') do |csv|
          attributes = %w[name group_id slug description location maxmembers date created_at]
          csv << attributes
          group.meetings.each do |meeting|
            csv << attributes.map { |attr| meeting.send(attr) }
            CSV.open("#{folder_name}/group_#{group.name}_meeting_#{meeting.name}_comments_data", 'wb') do |csv|

              attributes = %w[comment created_at]
              meeting.comments.where(visibility: "all").each do |comment|
                csv << attributes.map { |attr| comment.send(attr) }
              end


            end
          end
        end

      end

      # Moment export
      CSV.open("#{folder_name}/moment_data.csv", 'wb') do |csv|
        attributes = %w[name slug mood why fix created_at]
        csv << attributes
        user.moments.each do |moment|
          csv << attributes.map { |attr| moment.send(attr) }
        end
      end

      # Medications export
      CSV.open("#{folder_name}/medication_data.csv", 'wb') do |csv|
        attributes = %w[name dosage refill total strength]
        csv << attributes
        user.medications.each do |medication|
          csv << attributes.map { |attr| medication.send(attr) }
        end
      end

      # Mood export
      CSV.open("#{folder_name}/mood_data.csv", 'wb') do |csv|
        attributes = %w[name description created_at updated_at]
        csv << attributes
        user.moods.each do |mood|
          csv << attributes.map { |attr| mood.send(attr) }
        end
      end

      # input_directory = "app/assets/export/user_#{user.id}_data" # directory to be zipped
      # zipfile_name = "app/assets/export/user_#{user.id}_data.zip" # zip-file name
      #
      # puts input_directory
      # puts zipfile_name
      # # zip a folder with only files (NO SUB FOLDERS)
      # Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      #   Dir[File.join(input_directory, '*')].each do |file|
      #     zipfile.add(file.sub(input_directory, ''), file)
      #   end
      # end

      # user.update(export_request: false, export_available: true)
    end
  end

  desc 'TODO'
  task Remove: :environment do
  end

end
