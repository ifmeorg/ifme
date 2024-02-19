# frozen_string_literal: true
class CollectionPageSetupConcernTestController < ApplicationController
  include CollectionPageSetupConcern
end

describe CollectionPageSetupConcernTestController do
  let(:user) { create(:user) }

  it 'should set up a page with a search param' do
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:params).and_return(search: 'a value')
    page_collection = subject.page_collection('@categories', 'category')
    expect(subject.params[:search]).to eq 'a value'
    expect(page_collection).to be_truthy
  end

  describe 'for the Moments index page' do
    include MomentsHelper

    it 'should set up a page with a filters params with results' do
      moment_secret = create(:moment, :with_secret_share, name: 'Secret shared enabled', user: user)
      moment = create(:moment, name: 'Moment without secret', user: user)
      allow_any_instance_of(MomentsHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(MomentsHelper).to receive(:params).and_return({ filters: ['secret_share'] })
      page_collection = subject.page_collection('@moments', 'moment', multiselect_hash)
      expect(subject.instance_variable_get(:@moments).ids).to eq [moment_secret.id]
    end

    it 'should set up a page with a filters params with no results' do
      moment = create(:moment, name: 'Moment without secret', user: user)
      allow_any_instance_of(MomentsHelper).to receive(:current_user).and_return(user)
      allow_any_instance_of(MomentsHelper).to receive(:params).and_return({ filters: ['secret_share'] })
      page_collection = subject.page_collection('@moments', 'moment', multiselect_hash)
      expect(subject.instance_variable_get(:@moments).ids).to eq [moment.id]
    end
  end
end
