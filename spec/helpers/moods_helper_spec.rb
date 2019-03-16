# frozen_string_literal: true

describe MoodsHelper do
  let(:user) { create(:user) }
  let(:mood) { create(:mood, user_id: user.id) }
  let(:no_form_tag) { { noFormTag: true } }
  let(:mood_props) do
    {
      inputs: [
        {
          id: 'mood_name',
          type: 'text',
          name: 'mood[name]',
          label: t('common.name'),
          value: @mood.name || nil,
          required: true,
          dark: true
        },
        {
          id: 'mood_description',
          type: 'textarea',
          name: 'mood[description]',
          label: t('common.form.description'),
          value: @mood.description || nil,
          dark: true
        }
      ],
    }
  end

  let(:submit_field) do
    {
      id: 'submit',
      type: 'submit',
      value: t('common.actions.submit'),
      dark: true
    }
  end

  let(:update_input) do
    { id: '_method', name: '_method', type: 'hidden', value: 'patch' }
  end

  before(:example) do
    @mood = mood
  end

  describe '#new_mood_props' do
    before(:example) do
        mood_props[:action] = '/moods'
        mood_props[:inputs].push(submit_field)
    end

    it 'returns correct props' do
      expect(new_mood_props).to eq(mood_props)
    end
  end

  describe '#quick_create_mood_props' do
    before(:example) do
        mood_props[:action] = '/moods/quick_create'
        mood_props[:inputs].push(submit_field)
    end

    it 'returns correct props' do
      expect(quick_create_mood_props).to eq(mood_props.merge(no_form_tag))
    end
  end

  describe '#edit_mood_props' do
    before(:example) do
        mood_props[:action] = '/moods/test-mood'
        mood_props[:inputs].push(update_input).push(submit_field)
    end

    it 'returns correct props' do
      expect(edit_mood_props).to eq(mood_props)
    end
  end

end
