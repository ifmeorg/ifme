# frozen_string_literal: true

require 'csv'
require 'zip'
require 'zip_file'

namespace :data_export do
  desc 'Function exports the data'
  task :Add, [:id]=> :environment do |task, args|

    user = User.find(args[:id])

    folder_name = "app/assets/export/user_#{user.id}_data"
      # Dir.mkdir(folder_name) unless File.exists?(folder_name)
    Dir.mkdir(folder_name) unless File.exist?(folder_name)

      # Groups
    user.groups.each do |group|
      # Group info
      CSV.open("#{folder_name}/group_#{group.slug}_data.csv", 'wb') do |csv|
        attributes = %w[id name description created_at]
        csv << attributes
        user.groups.each do |group|
          csv << attributes.map { |attr| group.send(attr) }
        end
      end

      # Meeting info
      group.meetings.each do |meeting|
        CSV.open("#{folder_name}/group_#{group.name}_meeting_#{meeting.slug}_data.csv", 'wb') do |csv|
             attributes = %w[name group_id slug description location maxmembers date created_at]
             csv << attributes
             csv << attributes.map { |attr| meeting.send(attr) }
             CSV.open("#{folder_name}/group_#{group.name}_meeting_#{meeting.name}_comments_data.csv", 'wb') do |csv|

               attributes = %w[comment created_at]
               csv << attributes
               meeting.comments.where(visibility: 'all').each do |comment|
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


    directory_to_zip = folder_name
    output_file = folder_name + '.zip'
    zf = ZipFileGenerator.new(directory_to_zip, output_file)
    zf.write
    FileUtils.rm_rf("app/assets/export/user_#{user.id}_data")
    user.update(export_request: false, export_available: true, data_requested_on: Time.now)
  end

  desc 'Remove all users data after 30 days'
  task Remove: :environment do
    User.where(export_available: true).where('users.data_requested_on > ?', 30.days.ago).each do |user|
      puts "User#{user.name}"
      # FileUtils.rm_rf("app/assets/export/user_#{user.id}_data")
    end
  end

end
