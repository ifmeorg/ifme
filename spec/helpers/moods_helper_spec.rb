# frozen_string_literal: true

describe MoodsHelper do
  subject { TestClass.new(build(:mood, user_id: 999, id: 999)) }

  class TestClass
    include MoodsHelper
    include Rails.application.routes.url_helpers

    def initialize(mood)
      @mood = mood
    end

    def t(*args)
      I18n.t(*args)
    end
  end

  let(:mood_form_inputs_res) do
    [
      {
        id: 'mood_name',
        type: 'text',
        name: 'mood[name]',
        label: 'Name',
        value: 'Test Mood',
        required: true,
        dark: true
      },
      {
        id: 'mood_description',
        type: 'textarea',
        name: 'mood[description]',
        label: 'Description',
        value: 'Test Mood',
        dark: true
      }
    ]
  end

  describe '#new_mood_props' do
    it 'call method with correct params' do
      expect(subject).to receive(:new_form_props).with(mood_form_inputs_res, '/moods')
      subject.new_mood_props
    end
  end

  describe '#quick_create_mood_props' do
    it 'call method with correct params' do
      expect(subject).to receive(:quick_create_form_props).with(mood_form_inputs_res, '/moods/quick_create')
      subject.quick_create_mood_props
    end
  end

  describe '#edit_mood_props' do
    it 'call method with correct params' do
      expect(subject).to receive(:edit_form_props).with(mood_form_inputs_res, '/moods/999')
      subject.edit_mood_props
    end
  end
end
