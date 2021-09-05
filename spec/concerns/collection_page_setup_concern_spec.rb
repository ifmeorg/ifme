# frozen_string_literal: true
class CollectionPageSetupConcernTestController < ApplicationController
  include CollectionPageSetupConcern
end

describe CollectionPageSetupConcernTestController do
  let(:user) { create(:user) }
  it 'should setup a page' do
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:params).and_return(search: 'a value')
    page_collection = subject.page_collection('@categories', 'category')
    expect(subject.params[:search]).to eq 'a value'
    expect(page_collection).to be_truthy
  end

  it 'with filters should setup a page' do
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:params).and_return(filters: '0')
    page_collection = subject.page_collection('@moments', 'moment',
                                              {options: 'No viewers',
                                               filters: [{ viewers: [] }]})
    expect(subject.params[:filters]).to eq '0'
    expect(page_collection).to be_truthy
  end

  it 'with secret shared enable filter returns the due' do
    moment_secret = create(:moment, :with_secret_share, name: 'secret shared enable', user: user )
    moment = create(:moment, name: 'moment without secret', user: user ) 
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:params).and_return(filters: '0')
    page_collection = subject.page_collection('@moments', 'moment',
                                              {options: 'Secret share enabled',
                                               filters: ['secret_share_identifier IS NOT NULL']})
    expect(subject.instance_variable_get(:@moments).ids).to eq [moment_secret.id]
  end
end
