# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MedicationRefillHelper, type: :helper do
  include CalendarHelper
  include Devise::Test::ControllerHelpers

  describe '#save_refill_to_google_calendar' do
    let(:user) { FactoryBot.create(:user1) }
    let(:medication) { FactoryBot.create(:medication, user_id: user.id) }
    let(:exception_text) { 'RESCUE INVOKED' }
    let(:client_error_exception_text) { 'REDIRECTED TO SIGN IN BECAUSE RESCUE WAS INVOKED' }
    let(:server_error_exception_text) { 'REDIRECTED TO MEDICATION_PATH BECAUSE RESCUE WAS INVOKED' }

    before do
      allow_any_instance_of(helper.class).to receive(:return_to_sign_in).and_return(client_error_exception_text)
      allow_any_instance_of(helper.class).to receive(:redirect_to_medication).and_return(server_error_exception_text)
      allow_any_instance_of(User).to receive(:google_access_token).and_return('token')
      sign_in user
    end

    context 'when the user has the google oauth2 enabled and they need a new refill reminder' do
      before do
        allow_any_instance_of(User).to receive(:google_oauth2_enabled?).and_return(true)
        allow_any_instance_of(helper.class).to receive(:new_cal_refill_reminder_needed?).and_return(true)
      end

      context 'when upload event fails with client error' do
        before do
          allow_any_instance_of(CalendarUploader).to receive(:upload_event)
            .and_raise(Google::Apis::ClientError.new(exception_text))
        end

        it 'redirects to sign_in' do
          expect(helper.save_refill_to_google_calendar(medication)).to eq(false)
        end
      end

      context 'when upload event fails with server error' do
        before do
          allow_any_instance_of(CalendarUploader).to receive(:upload_event)
            .and_raise(Google::Apis::ServerError.new(exception_text))
        end

        it 'redirects to medication path' do
          expect(helper.save_refill_to_google_calendar(medication)).to eq(false)
        end
      end

      context 'when upload event passes' do
        before do
          allow_any_instance_of(CalendarUploader).to receive(:upload_event).and_return(true)
        end

        it { expect(helper.save_refill_to_google_calendar(medication)).to eq(true) }
      end
    end

    context "when the user has not google oauth2 enabled and/or they don't need a new refill reminder" do
      it { expect(helper.save_refill_to_google_calendar(medication)).to eq(true) }
    end
  end
end
