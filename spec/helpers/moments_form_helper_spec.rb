# frozen_string_literal: true

describe MomentsFormHelper do
  let(:user) { create(:user2, :with_allies) }
  let(:viewers) { user.allies }
  let(:category) { create(:category, user_id: user.id) }
  let(:mood) { create(:mood, user_id: user.id) }
  let(:strategy) { create(:strategy, user_id: user.id) }

  before do
    @moment = moment
    @viewers = viewers
    @categories = user.categories
    @moods = user.moods
    @strategies = user.strategies
  end

  describe '#new_moment_props' do
    let(:moment) { Moment.new }

    before do
      @category = Category.new
      @mood = Mood.new
      @strategy = Strategy.new
    end

    it 'returns correct props' do
      expect(new_moment_props).to eq(
        action: '/moments',
        inputs: [
          {
            dark: true,
            id: 'moment_name',
            label: 'Name',
            name: 'moment[name]',
            required: true,
            type: 'text',
            value: nil
          },
          {
            dark: true,
            id: 'moment_why',
            label: 'What happened and how do you feel?', name: 'moment[why]',
            required: true,
            type: 'textarea',
            value: nil
          },
          {
            dark: true,
            id: 'moment_fix',
            label: 'What thoughts would you like to have?', name: 'moment[fix]',
            required: false,
            type: 'textarea',
            value: nil
          },
          {
            checkboxes: [],
            formProps: {
              action: '/categories/quick_create',
              inputs: [
                {
                  dark: true,
                  id: 'category_name',
                  info: 'Categorize recurring people, places, things, activities, and more',
                  label: 'Name',
                  name: 'category[name]',
                  required: true,
                  type: 'text',
                  value: nil
                },
                {
                  dark: true,
                  id: 'category_description',
                  label: 'Description',
                  name: 'category[description]',
                  type: 'textarea',
                  value: nil
                },
                {
                  dark: true,
                  id: 'submit',
                  type: 'submit',
                  value: 'Submit'
                }
              ],
              noFormTag: true
            },
            id: 'moment_category',
            label: 'Categories',
            name: 'moment[category][]',
            placeholder: 'Search by keywords',
            type: 'quickCreate'
          },
          {
            checkboxes: [],
            formProps: {
              action: '/moods/quick_create',
              inputs: [
                {
                  dark: true,
                  id: 'mood_name',
                  label: 'Name',
                  name: 'mood[name]',
                  required: true,
                  type: 'text',
                  value: nil
                },
                {
                  dark: true,
                  id: 'mood_description',
                  label: 'Description',
                  name: 'mood[description]',
                  type: 'textarea',
                  value: nil
                },
                {
                  dark: true,
                  id: 'submit',
                  type: 'submit',
                  value: 'Submit'
                }
              ],
              noFormTag: true
            },
            id: 'moment_mood',
            label: 'Moods',
            name: 'moment[mood][]',
            placeholder: 'Search by keywords',
            type: 'quickCreate'
          },
          {
            checkboxes: [],
            formProps: {
              action: '/strategies/quick_create',
              inputs: [
                {
                  dark: true,
                  id: 'strategy_name',
                  label: 'Name',
                  name: 'strategy[name]',
                  placeholder: 'Any activity, train of thought, or form or self-care that helps you',
                  required: true,
                  type: 'text',
                  value: nil
                },
                {
                  dark: true,
                  id: 'strategy_description',
                  label: 'Describe the strategy.',
                  name: 'strategy[description]',
                  required: true,
                  type: 'textarea',
                  value: nil
                },
                {
                  dark: true,
                  id: 'submit',
                  type: 'submit',
                  value: 'Submit'
                }
              ],
              noFormTag: true
            },
            id: 'moment_strategy',
            label: 'Strategies',
            name: 'moment[strategy][]',
            placeholder: 'Search by keywords',
            type: 'quickCreate'
          },
          {
            accordion: true,
            checkboxes: [
              {
                checked: false,
                id: "moment_viewers_#{viewers[0].id}",
                label: 'Ally 0',
                value: viewers[0].id
              },
              {
                checked: false,
                id: "moment_viewers_#{viewers[1].id}",
                label: 'Ally 1',
                value: viewers[1].id
              },
              {
                checked: false,
                id: "moment_viewers_#{viewers[2].id}",
                label: 'Ally 2',
                value: viewers[2].id
              }
            ],
            dark: true,
            id: 'moment_viewers',
            label: 'Viewers',
            name: 'moment[viewers][]',
            placeholder: 'Allies who can view your moment', type: 'tag'
          },
          {
            checked: nil,
            dark: true,
            id: 'moment_comment',
            info: 'Only you and viewers can comment',
            label: 'Allow Comments?',
            name: 'moment[comment]',
            type: 'switch',
            uncheckedValue: false,
            value: true
          },
          {
            checked: true,
            dark: true,
            id: 'moment_publishing',
            label: 'Do you want to save your moment as draft?',
            name: 'publishing',
            type: 'switch',
            uncheckedValue: '1',
            value: '0'
          },
          {
            dark: true,
            id: 'submit',
            type: 'submit',
            value: 'Submit'
          }
        ]
      )
    end
  end

  describe '#edit_moment_props' do
    let(:moment) { FactoryBot.create(:moment, user: user, category: [category.id], mood: [mood.id], strategy: [strategy.id]) }

    before do
      @category = category
      @mood = mood
      @strategy = strategy
    end

    it 'returns correct props' do
      expect(edit_moment_props).to eq(
        inputs: [
          {
            id: 'moment_name',
            type: 'text',
            name: 'moment[name]',
            label: 'Name',
            value: 'Test Moment',
            required: true,
            dark: true
          },
          {
            id: 'moment_why',
            type: 'textarea',
            name: 'moment[why]',
            label: 'What happened and how do you feel?',
            value: 'Test Why',
            required: true,
            dark: true
          },
          {
            id: 'moment_fix',
            type: 'textarea',
            name: 'moment[fix]',
            label: 'What thoughts would you like to have?',
            value: 'Test fix',
            required: false,
            dark: true
          },
          {
            id: 'moment_category',
            type: 'quickCreate',
            name: 'moment[category][]',
            label: 'Categories',
            placeholder: 'Search by keywords',
            checkboxes: [
              {
                id: 'test-category',
                label: 'Test Category',
                value: category.id,
                checked: true
              }
            ],
            formProps: {
              inputs: [
                {
                  id: 'category_name',
                  type: 'text',
                  name: 'category[name]',
                  label: 'Name',
                  value: 'Test Category',
                  required: true,
                  info: 'Categorize recurring people, places, things, activities, and more',
                  dark: true
                },
                {
                  id: 'category_description',
                  type: 'textarea',
                  name: 'category[description]',
                  label: 'Description',
                  value: 'Test description category',
                  dark: true
                },
                {
                  id: 'submit',
                  type: 'submit',
                  value: 'Submit',
                  dark: true
                }
              ],
              action: '/categories/quick_create',
              noFormTag: true
            }
          },
          {
            id: 'moment_mood',
            type: 'quickCreate',
            name: 'moment[mood][]',
            label: 'Moods',
            placeholder: 'Search by keywords',
            checkboxes: [
              {
                id: 'test-mood',
                label: 'Test Mood',
                value: mood.id,
                checked: true
              }
            ],
            formProps: {
              inputs: [
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
                },
                {
                  id: 'submit',
                  type: 'submit',
                  value: 'Submit',
                  dark: true
                }
              ],
              action: '/moods/quick_create',
              noFormTag: true
            }
          },
          {
            id: 'moment_strategy',
            type: 'quickCreate',
            name: 'moment[strategy][]',
            label: 'Strategies',
            placeholder: 'Search by keywords',
            checkboxes: [
              {
                id: 'test-strategy',
                label: 'Test Strategy',
                value: strategy.id,
                checked: true
              }
            ],
            formProps: {
              inputs: [
                {
                  id: 'strategy_name',
                  type: 'text',
                  name: 'strategy[name]',
                  label: 'Name',
                  value: 'Test Strategy',
                  placeholder:
                  'Any activity, train of thought, or form or self-care that helps you',
                  required: true,
                  dark: true
                },
                {
                  id: 'strategy_description',
                  type: 'textarea',
                  name: 'strategy[description]',
                  label: 'Describe the strategy.',
                  value: 'Test Description',
                  required: true,
                  dark: true
                },
                {
                  id: 'submit',
                  type: 'submit',
                  value: 'Submit',
                  dark: true
                }
              ],
              action: '/strategies/quick_create',
              noFormTag: true
            }
          },
          {
            id: 'moment_viewers',
            name: 'moment[viewers][]',
            type: 'tag',
            checkboxes: [
              {
                id: "moment_viewers_#{viewers[0].id}",
                value: viewers[0].id,
                checked: false,
                label: 'Ally 0'
              },
              {
                id: "moment_viewers_#{viewers[1].id}",
                value: viewers[1].id,
                checked: false,
                label: 'Ally 1'
              },
              {
                id: "moment_viewers_#{viewers[2].id}",
                value: viewers[2].id,
                checked: false,
                label: 'Ally 2'
              }
            ],
            label: 'Viewers',
            placeholder: 'Allies who can view your moment',
            dark: true,
            accordion: true
          },
          {
            id: 'moment_comment',
            type: 'switch',
            name: 'moment[comment]',
            label: 'Allow Comments?',
            value: true,
            uncheckedValue: false,
            checked: true,
            info: 'Only you and viewers can comment',
            dark: true
          },
          {
            id: 'moment_publishing',
            type: 'switch',
            label: 'Do you want to save your moment as draft?',
            dark: true,
            name: 'publishing',
            value: '0',
            uncheckedValue: '1',
            checked: true
          },
          {
            id: '_method',
            name: '_method',
            type: 'hidden',
            value: 'patch'
          },
          {
            id: 'submit',
            type: 'submit',
            value: 'Submit',
            dark: true
          }
        ],
        action: '/moments/test-moment'
      )
    end
  end
end
