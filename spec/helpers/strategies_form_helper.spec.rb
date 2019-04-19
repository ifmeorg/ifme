# frozen_string_literal: true

describe StrategiesFormHelper do
  let(:user) { create(:user2, :with_allies) }
  let(:strategy) { create(:strategy, user: user) }
  let(:category_form_inputs_res) do
    {
      inputs: [
        {
          id: 'category_name',
          type: 'text',
          name: 'category[name]',
          label: t('common.name'),
          value: @category.name,
          required: true,
          info: t('categories.form.name_hint'),
          dark: true
        },
        {
          id: 'category_description',
          type: 'textarea',
          name: 'category[description]',
          label: t('common.form.description'),
          value: @category.description,
          dark: true
        },
        {
          id: 'submit',
          type: 'submit',
          value: t('common.actions.submit'),
          dark: true
        }
      ],
      action: '/categories/quick_create',
      noFormTag: true
    }
  end
  let(:build_strategy_name_res) do
    {
      id: 'strategy_name',
      type: 'text',
      name: 'strategy[name]',
      label: t('common.name'),
      value: strategy.name || nil,
      placeholder: t('strategies.form.name_hint'),
      required: true,
      dark: true
    }
  end
  let(:build_strategy_description_res) do
    {
      id: 'strategy_description',
      type: 'textarea',
      name: 'strategy[description]',
      label: t('strategies.form.describe'),
      value: strategy.description || nil,
      required: true,
      dark: true
    }
  end
  let(:build_strategy_category_res) do
    {
      id: 'strategy_category',
      type: 'quickCreate',
      name: 'strategy[category][]',
      label: t('categories.plural'),
      placeholder: t('common.form.search_by_keywords'),
      checkboxes: category_checkboxes,
      formProps: category_form_inputs_res
    }
  end
  let(:build_strategy_reminder_res) do
    {
      id: 'strategy_perform_strategy_reminder',
      name: 'strategy[perform_strategy_reminder_attributes][active]',
      label: t('common.daily_reminder'),
      info: t('strategies.form.daily_reminder_hint'),
      value: true,
      uncheckedValue: false,
      checked: strategy&.perform_strategy_reminder&.active,
      dark: true
    }
  end
  let(:build_strategy_reminder_attributes_res) do
    {
      id: 'strategy_perform_strategy_reminder_attributes_id',
      name: 'strategy[perform_strategy_reminder_attributes][id]',
      type: 'hidden',
      value: strategy&.perform_strategy_reminder&.id
    }
  end
  let(:build_strategy_comment_res) do
    build_switch_input_strategy_comment_res.merge(
      id: 'strategy_comment',
      name: 'strategy[comment]',
      label: t('comment.allow_comments'),
      info: t('comment.hint')
    )
  end
  let(:build_strategy_publishing_res) do
    build_switch_input_strategy_publishing_res.merge(
      id: 'strategy_publishing',
      name: 'publishing',
      label: t('strategies.form.draft_question')
    )
  end
  let(:build_switch_input_strategy_comment_res) do
    {
      type: 'switch',
      value: true,
      uncheckedValue: false,
      checked: strategy.comment,
      dark: true
    }
  end
  let(:build_switch_input_strategy_publishing_res) do
    {
      type: 'switch',
      value: '0',
      uncheckedValue: '1',
      checked: !strategy.published?,
      dark: true
    }
  end
  let(:category_checkboxes_res) do
    [
      {
        id: @category.slug,
        label: @category.name,
        value: @category.id,
        checked: @strategy.category.include?(@category.id)
      }
    ]
  end

  before(:each) do
    @categories = []
    @category = create(:category, user: user)
  end

  describe '#build_strategy_name' do
    subject { build_strategy_name(strategy) }

    it 'builds correct strategy name' do
      expect(subject).to eq(build_strategy_name_res)
    end
  end

  describe '#build_strategy_description' do
    subject { build_strategy_description(strategy) }

    it 'builds correct strategy description' do
      expect(subject).to eq(build_strategy_description_res)
    end
  end

  describe '#build_strategy_category' do
    subject { build_strategy_category }

    it 'builds correct strategy category' do
      expect(subject).to eq(build_strategy_category_res)
    end
  end

  describe '#build_strategy_reminder' do
    subject { build_strategy_reminder(strategy) }

    it 'builds correct strategy name' do
      expect(subject).to eq(build_strategy_reminder_res)
    end
  end

  describe '#build_strategy_reminder_attributes' do
    subject { build_strategy_reminder_attributes(strategy) }

    it 'builds correct strategy name' do
      expect(subject).to eq(build_strategy_reminder_attributes_res)
    end
  end

  describe '#build_strategy_comment' do
    subject { build_strategy_comment(strategy) }

    it 'builds correct strategy name' do
      expect(subject).to eq(build_strategy_comment_res)
    end
  end

  describe '#build_strategy_publishing' do
    subject { build_strategy_publishing(strategy) }

    it 'builds correct strategy name' do
      expect(subject).to eq(build_strategy_publishing_res)
    end
  end

  describe '#build_switch_input' do
    subject { build_switch_input(true, strategy.comment, false) }

    it 'builds correct switch input' do
      expect(subject).to eq(build_switch_input_strategy_comment_res)
    end
  end

  describe '#category_checkboxes' do
    subject { category_checkboxes }

    context 'has no categories' do
      it 'returns empty array' do
        expect(subject).to eq([])
      end
    end

    context 'does have categories' do
      before { @categories.push(@category) }
      before { @strategy = strategy }
      it 'returns correct checkboxes' do
        expect(subject).to eq(category_checkboxes_res)
      end
    end
  end
end
