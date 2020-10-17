# frozen_string_literal: true
# == Schema Information
#
# Table name: users_data_requests
#
#  id         :bigint           not null, primary key
#  request_id :string           not null
#  status_id  :integer          not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Users
  class DataRequest < ApplicationRecord
    STATUS = {
      enqueued: 1,
      success: 2,
      failed: 3,
      deleted: 4
    }.freeze

    ASSOCIATIONS_TO_EXPORT = %i[
      allyships
      group_members
      groups
      categories
      medications
      strategies
      moments
      notifications
      moods
      care_plan_contacts
      meeting_members
    ].freeze

    DEFAULT_FILE_PATH = Rails.root.join('tmp', 'csv_data')

    belongs_to :user, class_name: '::User', foreign_key: 'user_id'

    after_commit :after_commit_tasks

    validates :user_id, uniqueness: {
      scope: :status_id,
      message: 'There is already a request enqueued for this user.'
    },
                        if: -> { status_id == STATUS[:enqueued] }

    validates :request_id, uniqueness: {
      message: 'There is already a request with this request_id.'
    }

    validates :status_id, inclusion: {
      in: STATUS.values,
      message: proc { |request| "'#{request.status_id}' is not valid." }
    },
                          presence: true

    validates :request_id, presence: true

    def after_commit_tasks
      return unless saved_change_to_id? && status_id == STATUS[:enqueued]

      Dir.mkdir(DEFAULT_FILE_PATH) unless File.exist?(DEFAULT_FILE_PATH)

      enqueue_download_request
    end

    def enqueue_download_request
      ProcessDataRequestWorker.perform_async(request_id)
    end

    def create_csv
      user = User.includes(*ASSOCIATIONS_TO_EXPORT).find(user_id)
      begin
        require 'csv'
        csv_rows = user.build_csv_data
        write_to_csv(csv_rows)
        self.status_id = STATUS[:success]
        save!
        user.delete_stale_data_file
      rescue StandardError
        File.delete(file_path) if file_path.present? && File.exist?(file_path)
        self.status_id = STATUS[:failed]
        save!
      end
    end

    def file_path
      DEFAULT_FILE_PATH.join("#{request_id}.csv").to_s
    end

    private

    def write_to_csv(csv_rows)
      CSV.open(file_path, 'wb') do |csv_row|
        csv_rows.each do |row|
          csv_row << row
        end
      end
    end
  end
end
