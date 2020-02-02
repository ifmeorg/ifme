# frozen_string_literal: true
describe SharedBasicConcern, type: :controller do
  class Test
    def initialize(args = nil)
      @id = args[:user_id]
      @name = args[:name]
      @description = args[:description]
    end

    def to_hash
      hash = {}
      instance_variables.each do |var|
        hash[var.to_s.delete('@').to_sym] =
          instance_variable_get(var)
      end
      hash
    end
  end

  class TestController < ApplicationController
  end

  controller(TestController) do
    include SharedBasicConcern

    def quick_create
      @params =
        { 'test' => { name: 'test', description: 'This is a test' } }
      shared_quick_create_basic(Test, @params)
    end
  end

  let(:user) { create(:user) }

  describe '#quick_create' do
    let(:user) { FactoryBot.create(:user1) }
    let(:result) do
      {
        name: 'test',
        description: 'This is a test'
      }
    end

    before { allow(controller).to receive(:current_user).and_return(user) }
    before do
      allow(controller).to receive(:shared_quick_create)
        .and_wrap_original { |_m, *args| args[0] }
    end

    it 'creates the entity correctly' do
      expect(controller.quick_create.to_hash).to include(result)
    end
  end
end
