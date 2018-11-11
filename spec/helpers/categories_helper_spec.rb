# frozen_string_literal: true
describe CategoriesHelper do
  let(:user) { build(:user) }
  let(:category) { build(:category, user_id: user.id) }
  let(:quick_create) { false }
  let(:no_form_tag) do
    { noFormTag: true }
  end
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
        {
          dark: true,
          id: 'submit',
          type: 'submit',
          value: 'Submit'
        }
      ],
      action: quick_create ? '/categories/quick_create' : '/categories'
    }
  end

  describe '#new_category_props' do
    context 'category is nil' do
      let(:category) { nil }

      it 'returns correct results' do
        expect(new_category_props(category)).to eq(category_props)
      end
    end

    context 'category exists' do
      it 'returns correct results' do
        expect(new_category_props(category)).to eq(category_props)
      end
    end
  end

  describe '#quick_create_category_props' do
    let(:quick_create) { true }

    context 'category is nil' do
      let(:category) { nil }

      it 'returns correct results' do
        expect(quick_create_category_props(category)).to eq(category_props.merge(no_form_tag))
      end
    end

    context 'category exists' do
      it 'returns correct results' do
        expect(quick_create_category_props(category)).to eq(category_props.merge(no_form_tag))
      end
    end
  end

  describe '#new_category_props' do
    context 'category is nil' do
      it 'returns correct results' do
        expect(new_category_props(category)).to eq(category_props)
      end
    end

    context 'category exists' do
      it 'returns correct results' do
        expect(new_category_props(category)).to eq(category_props)
      end
    end
  end
end
