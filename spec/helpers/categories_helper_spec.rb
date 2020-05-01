# frozen_string_literal: true

describe CategoriesHelper do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:quick_create) { false }
  let(:category_props) do
    {
      inputs: [
        {
          id: 'category_name',
          type: 'text',
          name: 'category[name]',
          label: 'Name',
          value: category&.name || nil,
          required: true,
          info: 'Categorize recurring people, places, things, activities, and more',
          dark: true
        },
        {
          id: 'category_description',
          type: 'textarea',
          name: 'category[description]',
          label: 'Description',
          value: category&.description || nil,
          dark: true
        },
        { id: 'category_visible',
          type: 'switch',
          label: t('shared.stats.visible_in_stats'),
          dark: true,
          name: 'category[visible]',
          value: true,
          uncheckedValue: false,
          checked: category&.visible || nil,
        },
        {
          dark: true,
          id: 'submit',
          type: 'submit',
          value: 'Submit',
          name: 'commit'
        }
      ],
      action: quick_create ? '/categories/quick_create' : '/categories'
    }
  end

  before do
    @category = category
  end

  describe '#new_category_props' do
    context 'category is nil' do
      let(:category) { nil }

      it 'returns correct results' do
        expect(new_category_props).to eq(category_props)
      end
    end

    context 'category exists' do
      it 'returns correct results' do
        expect(new_category_props).to eq(category_props)
      end
    end
  end

  describe '#quick_create_category_props' do
    let(:quick_create) { true }

    context 'category is nil' do
      let(:category) { nil }

      it 'returns correct results' do
        expect(quick_create_category_props).to eq(category_props)
      end
    end

    context 'category exists' do
      it 'returns correct results' do
        expect(quick_create_category_props).to eq(category_props)
      end
    end
  end

  describe '#new_category_props' do
    context 'category is nil' do
      it 'returns correct results' do
        expect(new_category_props).to eq(category_props)
      end
    end

    context 'category exists' do
      it 'returns correct results' do
        expect(new_category_props).to eq(category_props)
      end
    end
  end

  describe '#present_category_or_mood' do
    subject { present_category_or_mood(category) }
    it 'returns correct data' do
      expect(subject.keys).to include(:name, :link, :actions)
      expect(subject[:link]).to eq(category_path(category))
      expect(subject[:name]).to eq(category[:name])
    end
  end
end
