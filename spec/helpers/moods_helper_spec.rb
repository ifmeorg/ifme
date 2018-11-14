# frozen_string_literal: true

describe MoodsHelper do
  let(:user) { create(:user) }
  let(:mood) { build(:mood, user_id: user.id) }
  let(:quick_create) { false }
  let(:mood_props) do
    {
      inputs: [
        {
          id: 'mood_name',
          type: 'text',
          name: 'mood[name]',
          label: t('common.name'),
          value: mood&.name || nil,
          required: true,
          dark: true
        },
        {
          id: 'mood_description',
          type: 'textarea',
          name: 'mood[description]',
          label: t('common.form.description'),
          value: mood&.description || nil,
          dark: true
        },
        {
          id: 'submit',
          type: 'submit',
          value: 'Submit',
          dark: true
        }
      ],
      action: quick_create ? '/moods/quick_create' : '/moods'
    }
  end


  describe '#new_mood_props' do
    it 'returns correct props' do
      expect(new_mood_props).to eq(mood_props)
    end
  end

  describe '#quick_create_mood_props' do
    before(:example) do
      let(:quick_create) { true }
    end

    it 'returns correct props' do
      expect(quick_create_mood_props).to eq(mood_props.merge(no_form_tag))
    end
  end

  describe '#edit_form_props' do
    it 'returns correct props' do
      expect(edit_form_props).to eq(mood_props)
    end
  end

end
