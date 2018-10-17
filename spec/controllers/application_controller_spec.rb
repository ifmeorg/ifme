# frozen_string_literal: true

require_relative './shared_examples'

include ActionView::Helpers::DateHelper
include ActionView::Helpers::TextHelper

describe ApplicationController do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  describe '#most_focus' do
    it_behaves_like :most_focus, :category
    it_behaves_like :most_focus, :mood
    it_behaves_like :most_focus, :strategy
  end
end
