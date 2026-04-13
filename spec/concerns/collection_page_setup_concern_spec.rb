# frozen_string_literal: true

require 'spec_helper'

class CollectionPageSetupConcernTestController < ApplicationController
  include CollectionPageSetupConcern
end

describe CollectionPageSetupConcernTestController, type: :controller do
  let(:user) { create(:user) }

  let(:multiselect_config) do
    {
      filters: {
        # We'll use a simple attribute filter to prove the concern works
        'secret_share' => { name: 'Filtered Name' }
      },
      checkboxes: []
    }
  end

  before do
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:t).and_return("New Moment")
  end

  describe 'for the Moments index page' do
    it 'should set up a page with a filters params with results' do
      # Create the moment that matches the filter
      target_moment = create(:moment, name: 'Filtered Name', user: user)
      # Create one that doesn't
      create(:moment, name: 'Other Name', user: user)

      allow(subject).to receive(:params).and_return(
        ActionController::Parameters.new({ filters: ['secret_share'] })
      )

      subject.page_collection('@moments', 'moment', multiselect_config)

      results = subject.instance_variable_get(:@moments)
      expect(results.count).to eq(1)
      expect(results.first.name).to eq('Filtered Name')
    end

    it 'should set up a page with a filters params with no results' do
      create(:moment, name: 'Other Name', user: user)

      allow(subject).to receive(:params).and_return(
        ActionController::Parameters.new({ filters: ['secret_share'] })
      )

      # Your concern returns 'user' (all moments) if filtered count is 0
      subject.page_collection('@moments', 'moment', multiselect_config)

      results = subject.instance_variable_get(:@moments)
      # Falls back to the 'user' scope, so it should find the 1 moment
      expect(results.count).to eq(1)
    end
  end
end