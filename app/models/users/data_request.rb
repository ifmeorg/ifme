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

class Users::DataRequest < ApplicationRecord

  STATUS = {
    enqueued: 1,
    success: 2,
    failed: 3,
    deleted: 4
  }.freeze

  ASSOCIATIONS_TO_EXPORT = %i{
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
  }

  DEFAULT_FILE_PATH = "#{Rails.root}/tmp/csv_data/".freeze

  belongs_to :user, class_name: '::User', foreign_key: "user_id"
  
  after_commit :after_commit_tasks

  validates_uniqueness_of :user_id, scope: [:status_id],
    message: "There's already a request enqueued for this user.", if: -> {self.status_id == STATUS[:enqueued]}

  validates_uniqueness_of :request_id,
    message: "There's already a request with this request_id."
  
  validates :status_id,
    inclusion: {
      in: STATUS.values,
      message: proc { |request| "'#{request.status_id}' is not valid."}
    },
    presence: true

  validates :request_id, presence: true

  attr_accessor :file_path

  def after_commit_tasks()
    enqueue_download_request() if (self.saved_change_to_id? && self.status_id == STATUS[:enqueued]) 
  end

  def enqueue_download_request()
    ProcessDataRequestWorker.perform_async(self.request_id)
  end

  def create_csv()
    Dir.mkdir(DEFAULT_FILE_PATH) unless File.exist?(DEFAULT_FILE_PATH)
    user = User.includes(*ASSOCIATIONS_TO_EXPORT).find(self.user_id)
    begin
      require 'csv'
      csv_rows = user.build_csv_data()
      CSV.open("#{self.file_path}","wb") do |csv_row|
        csv_rows.each do |row|
          csv_row << row
        end
      end
      self.status_id = STATUS[:success]
      self.save!
      user.delete_stale_data_file()
    rescue => e
      File.delete(self.file_path) if (self.file_path.present? && File.exist?(self.file_path))
      self.status_id = STATUS[:failed]
      self.save!
    end
  end

  def file_path()
    return "#{DEFAULT_FILE_PATH}#{self.request_id}.csv"
  end
end
