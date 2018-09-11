class CollectionPageSetupTestController < ApplicationController
  include CollectionPageSetup
end

describe CollectionPageSetupTestController do
  it 'should setup a page' do
    user = create(:user)
    allow(subject).to receive(:current_user).and_return(user)
    allow(subject).to receive(:params).and_return(search: 'a value')
    page_collection = subject.page_collection('@categories', 'category')
    expect(subject.params[:search]).to eq 'a value'
    expect(page_collection).to be_truthy
  end
end