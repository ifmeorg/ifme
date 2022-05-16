# frozen_string_literal: true

describe StrategiesHelper do
  include FormHelper
  include ViewersHelper

  let(:user) { create(:user2, :with_allies) }
  let(:strategy) { create(:strategy, user: user) }
  let(:viewers) { user.allies_by_status(:accepted) }
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
          id: 'category_visible',
          type: 'switch',
          label: t('shared.stats.make_visible_in_stats'),
          dark: true,
          name: 'category[visible]',
          value: true,
          uncheckedValue: false,
          checked: @category.visible,
        },
        {
          id: 'submit',
          type: 'submit',
          value: t('common.actions.submit'),
          dark: true,
          name: 'commit'
        }
      ],
      action: '/categories/quick_create'
    }
  end
  let(:strategy_form_inputs_res) do
    [
      {
        id: 'strategy_name',
        type: 'text',
        name: 'strategy[name]',
        label: t('common.name'),
        value: strategy.name || nil,
        placeholder: t('strategies.form.name_hint'),
        required: true,
        dark: true
      },
      {
        id: 'strategy_description',
        type: 'textarea',
        name: 'strategy[description]',
        label: t('strategies.form.describe'),
        value: strategy.description || nil,
        required: true,
        dark: true
      },
      {
        id: 'strategy_category',
        type: 'quickCreate',
        name: 'strategy[category][]',
        label: t('categories.plural'),
        placeholder: t('common.form.search_by_keywords'),
        checkboxes: category_checkboxes,
        formProps: category_form_inputs_res
      },
      get_viewers_input(viewers, 'strategy', 'strategies', strategy),
      {
        id: 'strategy_comment',
        type: 'switch',
        name: 'strategy[comment]',
        label: t('comment.allow_comments'),
        value: true,
        uncheckedValue: false,
        checked: strategy.comment,
        info: t('comment.hint'),
        dark: true
      },
      {
        id: 'strategy_publishing',
        type: 'switch',
        label: t('strategies.form.draft_question'),
        dark: true,
        name: 'publishing',
        value: '0',
        uncheckedValue: '1',
        checked: strategy.published?
      },
      { id: 'strategy_visible',
        type: 'switch',
        label: t('shared.stats.make_visible_in_stats'),
        dark: true,
        name: 'strategy[visible]',
        value: true,
        uncheckedValue: false,
        checked: strategy.visible
      },
      {
        checked: false,
        dark: true,
        id: 'strategy_bookmarked',
        info: 'Bookmarked strategies appear in your Care Plan', label: 'Bookmark this strategy?',
        name: 'strategy[bookmarked]',
        type: 'switch',
        uncheckedValue: false,
        value: true
      },
      {
        id: 'strategy_perform_strategy_reminder',
        type: 'checkbox',
        name: 'strategy[perform_strategy_reminder_attributes][active]',
        label: t('common.daily_reminder'),
        info: t('strategies.form.daily_reminder_hint'),
        value: true,
        uncheckedValue: false,
        checked: strategy&.perform_strategy_reminder&.active,
        dark: true
      },
      {
        id: 'strategy_perform_strategy_reminder_attributes_id',
        name: 'strategy[perform_strategy_reminder_attributes][id]',
        type: 'hidden',
        value: strategy&.perform_strategy_reminder&.id
      }
    ]
  end
  let(:strategy_form_inputs_edit_res) do
    [
      {
        id: 'strategy_name',
        type: 'text',
        name: 'strategy[name]',
        label: t('common.name'),
        value: strategy.name || nil,
        placeholder: t('strategies.form.name_hint'),
        required: true,
        dark: true
      },
      {
        id: 'strategy_description',
        type: 'textarea',
        name: 'strategy[description]',
        label: t('strategies.form.describe'),
        value: strategy.description || nil,
        required: true,
        dark: true
      },
      {
        id: 'strategy_category',
        type: 'quickCreate',
        name: 'strategy[category][]',
        label: t('categories.plural'),
        placeholder: t('common.form.search_by_keywords'),
        checkboxes: category_checkboxes,
        formProps: category_form_inputs_res
      },
      get_viewers_input(viewers, 'strategy', 'strategies', strategy),
      {
        id: 'strategy_comment',
        type: 'switch',
        name: 'strategy[comment]',
        label: t('comment.allow_comments'),
        value: true,
        uncheckedValue: false,
        checked: strategy.comment,
        info: t('comment.hint'),
        dark: true
      },
      {
        id: 'strategy_publishing',
        type: 'switch',
        label: t('strategies.form.draft_question'),
        dark: true,
        name: 'publishing',
        value: '0',
        uncheckedValue: '1',
        checked: !strategy.published?
      },
      { id: 'strategy_visible',
        type: 'switch',
        label: t('shared.stats.make_visible_in_stats'),
        dark: true,
        name: 'strategy[visible]',
        value: true,
        uncheckedValue: false,
        checked: strategy.visible
      },
      {
        checked: false,
        dark: true,
        id: 'strategy_bookmarked',
        info: 'Bookmarked strategies appear in your Care Plan', label: 'Bookmark this strategy?',
        name: 'strategy[bookmarked]',
        type: 'switch',
        uncheckedValue: false,
        value: true
      },
      {
        id: 'strategy_perform_strategy_reminder',
        type: 'checkbox',
        name: 'strategy[perform_strategy_reminder_attributes][active]',
        label: t('common.daily_reminder'),
        info: t('strategies.form.daily_reminder_hint'),
        value: true,
        uncheckedValue: false,
        checked: strategy&.perform_strategy_reminder&.active,
        dark: true
      },
      {
        id: 'strategy_perform_strategy_reminder_attributes_id',
        name: 'strategy[perform_strategy_reminder_attributes][id]',
        type: 'hidden',
        value: strategy&.perform_strategy_reminder&.id
      }
    ]
  end

  before(:each) do
    @categories = []
    @category = create(:category, user: user)
  end

  describe '#new_strategy_props' do
    subject { new_strategy_props(strategy, viewers) }

    it 'returns correct props' do
      expect(subject).to eq(new_form_props(strategy_form_inputs_res, '/strategies'))
    end
  end

  describe '#quick_create_strategy_props' do
    before { @strategy = strategy }

    subject { quick_create_strategy_props }

    it 'returns correct props' do
      quick_strategy_form_inputs_res = [
        strategy_form_inputs_res[0],
        strategy_form_inputs_res[1]
      ]

      expect(subject).to eq(quick_create_form_props(
                              quick_strategy_form_inputs_res,
                              '/strategies/quick_create'
                            ))
    end
  end

  describe '#edit_strategy_props' do
    subject { edit_strategy_props(strategy, viewers) }

    it 'returns correct props' do
      expect(subject).to eq(
        edit_form_props(
          strategy_form_inputs_edit_res,
          "/strategies/#{strategy.slug}"
        )
      )
    end
  end
end
