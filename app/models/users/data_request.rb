# frozen_string_literal: true
# == Schema Information
#
# Table name: users_data_requests
#
#  id         :bigint           not null, primary key
#  file_data  :binary
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

    belongs_to :user, class_name: '::User'

    validates :user_id, uniqueness: {
                          scope: :status_id,
                          message: ->(_obj, _data) { I18n.t('users.data_request.errors.enqueued_for_user') }
                        },
                        if: -> { status_id == STATUS[:enqueued] }

    validates :request_id, uniqueness: {
      message: ->(_obj, _data) { I18n.t('users.data_request.errors.duplicate_request_id') }
    }

    validates :status_id, inclusion: {
                            in: STATUS.values,
                            message: proc { |request| "'#{request.status_id}' is not valid." }
                          },
                          presence: true

    validates :request_id, presence: true

    def create_csv
      user = User.find(user_id)
      begin
        require 'csv'
        require 'zlib'
        write_to_csv(user)
        self.status_id = STATUS[:success]
        save!
        user.delete_stale_data_file
      rescue StandardError
        self.file_data = nil
        self.status_id = STATUS[:failed]
        save!
      end
    end

    private

    def write_to_csv(user)
      buffer = StringIO.new
      Zlib::GzipWriter.wrap(buffer) do |gz|
        csv = CSV.new(gz)
        user.build_csv_data { |row| csv << row }
      end
      self.file_data = buffer.string
    end
  end
end
