# frozen_string_literal: true
require_relative './shared_examples'

describe MostFocusHelper, type: :controller do
  controller(ApplicationController) do
  end

  describe '#most_focus' do
    it_behaves_like :most_focus, :category
    it_behaves_like :most_focus, :mood
    it_behaves_like :most_focus, :strategy
  end
end
