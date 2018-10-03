# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MedicationRefillHelper, type: :helper do
  include CalendarHelper
  include Devise::Test::ControllerHelpers

  describe '#save_refill_to_google_calendar' do
    let(:user) { FactoryBot.create(:user1) }
    let(:medication) { FactoryBot.create(:medication, user_id: user.id) }
    let(:exception_text) { 'RESCUE INVOKED' }

    before do
      allow_any_instance_of(helper.class).to receive(:return_to_sign_in).and_return(exception_text)
      sign_in user
    end

    context 'when the user has the google oauth2 enabled and he need a new refill reminder needed' do
      before do
        allow_any_instance_of(User).to receive(:google_oauth2_enabled?).and_return(true)
        allow_any_instance_of(helper.class).to receive(:new_cal_refill_reminder_needed?).and_return(true)
      end

      it { expect(helper.save_refill_to_google_calendar(medication)).to eq(exception_text) }
    end

    context 'when the user has not google oauth2 enabled and/or he no need a new refill reminder' do
      it { expect(helper.save_refill_to_google_calendar(medication)).to eq(true) }
    end
  end
end
