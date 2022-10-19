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

    params[:controller] = 'moments'
    allow_to_receive(:current_user, user)
  end

  describe '#new_moment_props' do
    let(:moment) { Moment.new }

    before do
      @category = Category.new
      @mood = Mood.new
      @strategy = Strategy.new

      allow(controller).to receive(:action_name).and_return('create')
    end

    subject { new_moment_props }

    context 'when there are no moment templates' do
      it 'returns correct props' do
        expect(subject).to eq(
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
              label: 'Write about it', name: 'moment[why]',
              options: [],
              required: true,
              type: 'textareaTemplate',
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
                    id: 'category_visible',
                    type: 'switch',
                    label: t('shared.stats.make_visible_in_stats'),
                    dark: true,
                    name: 'category[visible]',
                    value: true,
                    uncheckedValue: false,
                    checked: true,
                  },
                  {
                    dark: true,
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    name: 'commit'
                  }
                ]
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
                    id: 'mood_visible',
                    label: t('shared.stats.make_visible_in_stats'),
                    name: 'mood[visible]',
                    type: 'switch',
                    value: true,
                    uncheckedValue: false,
                    checked: true
                  },
                  {
                    dark: true,
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    name: 'commit'
                  }
                ]
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
                    value: 'Submit',
                    name: 'commit'
                  }
                ]
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
              checked: false,
              dark: true,
              id: 'moment_publishing',
              label: 'Do you want to save your moment as draft?',
              name: 'publishing',
              type: 'switch',
              uncheckedValue: '1',
              value: '0'
            },
            {
              id: 'moment_bookmarked',
              checked: false,
              dark: true,
              info: 'Bookmarked moments appear in your Care Plan',
              label: 'Bookmark this moment?',
              name: 'moment[bookmarked]',
              type: 'switch',
              uncheckedValue: false,
              value: true
            },
            {
              id: 'moment_resource_recommendations',
              type: 'switch',
              name: 'moment[resource_recommendations]',
              label: 'Display Resource Recommendations?',
              value: true,
              uncheckedValue: false,
              checked: true,
              dark: true
            },
            {
              dark: true,
              id: 'submit',
              type: 'submit',
              value: 'Submit',
              name: 'commit'
            }
          ]
        )
      end
    end

    context 'when there are moment templates' do
      let!(:moment_template) { create(:moment_template, user_id: user.id) }

      it 'returns correct props' do
        expect(subject).to eq(
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
              label: 'Write about it', name: 'moment[why]',
              options: [{
                id: 'test-moment-template-name',
                label: 'Test Moment Template Name',
                value: 'Test Moment Template Description'
              }],
              required: true,
              type: 'textareaTemplate',
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
                    id: 'category_visible',
                    type: 'switch',
                    label: t('shared.stats.make_visible_in_stats'),
                    dark: true,
                    name: 'category[visible]',
                    value: true,
                    uncheckedValue: false,
                    checked: true,
                  },
                  {
                    dark: true,
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    name: 'commit'
                  }
                ]
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
                    id: 'mood_visible',
                    label: t('shared.stats.make_visible_in_stats'),
                    name: 'mood[visible]',
                    type: 'switch',
                    value: true,
                    uncheckedValue: false,
                    checked: true
                  },
                  {
                    dark: true,
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    name: 'commit'
                  }
                ]
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
                    value: 'Submit',
                    name: 'commit'
                  }
                ]
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
              checked: false,
              dark: true,
              id: 'moment_publishing',
              label: 'Do you want to save your moment as draft?',
              name: 'publishing',
              type: 'switch',
              uncheckedValue: '1',
              value: '0'
            },
            {
              id: 'moment_bookmarked',
              checked: false,
              dark: true,
              info: 'Bookmarked moments appear in your Care Plan',
              label: 'Bookmark this moment?',
              name: 'moment[bookmarked]',
              type: 'switch',
              uncheckedValue: false,
              value: true
            },
            {
              id: 'moment_resource_recommendations',
              type: 'switch',
              name: 'moment[resource_recommendations]',
              label: 'Display Resource Recommendations?',
              value: true,
              uncheckedValue: false,
              checked: true,
              dark: true
            },
            {
              dark: true,
              id: 'submit',
              type: 'submit',
              value: 'Submit',
              name: 'commit'
            }
          ]
        )
      end
    end
  end

  describe '#edit_moment_props' do
    let(:moment) { FactoryBot.create(:moment, user: user, category: [category.id], mood: [mood.id], strategy: [strategy.id], resource_recommendations: false) }

    before do
      @category = category
      @mood = mood
      @strategy = strategy

      allow(controller).to receive(:action_name).and_return('edit')
      allow(subject).to receive(:current_user).and_return(user)
    end

    subject { edit_moment_props }

    context 'when there are no moment templates' do
      it 'returns correct props' do
        expect(subject).to eq(
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
              type: 'textareaTemplate',
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
                    id: 'category_visible',
                    type: 'switch',
                    label: t('shared.stats.make_visible_in_stats'),
                    dark: true,
                    name: 'category[visible]',
                    value: true,
                    uncheckedValue: false,
                    checked: true,
                  },
                  {
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    dark: true,
                    name: 'commit'
                  }
                ],
                action: '/categories/quick_create'
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
                    dark: true,
                    id: 'mood_visible',
                    label: t('shared.stats.make_visible_in_stats'),
                    name: 'mood[visible]',
                    type: 'switch',
                    value: true,
                    uncheckedValue: false,
                    checked: true
                  },
                  {
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    dark: true,
                    name: 'commit'
                  }
                ],
                action: '/moods/quick_create'
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
                    dark: true,
                    name: 'commit'
                  }
                ],
                action: '/strategies/quick_create'
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
              id: 'moment_bookmarked',
              checked: false,
              dark: true,
              info: 'Bookmarked moments appear in your Care Plan',
              label: 'Bookmark this moment?',
              name: 'moment[bookmarked]',
              type: 'switch',
              uncheckedValue: false,
              value: true
            },
            {
              id: 'moment_resource_recommendations',
              type: 'switch',
              name: 'moment[resource_recommendations]',
              label: 'Display Resource Recommendations?',
              value: true,
              uncheckedValue: false,
              checked: false,
              dark: true
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
              dark: true,
              name: 'commit'
            }
          ],
          action: '/moments/test-moment'
        )
      end
    end

    context 'when there are moment templates' do
      let(:moment_template) { create(:moment_template, user_id: user.id) }

      it 'returns correct props' do
        expect(subject).to eq(
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
              type: 'textareaTemplate',
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
                    id: 'category_visible',
                    type: 'switch',
                    label: t('shared.stats.make_visible_in_stats'),
                    dark: true,
                    name: 'category[visible]',
                    value: true,
                    uncheckedValue: false,
                    checked: true,
                  },
                  {
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    dark: true,
                    name: 'commit'
                  }
                ],
                action: '/categories/quick_create'
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
                    dark: true,
                    id: 'mood_visible',
                    label: t('shared.stats.make_visible_in_stats'),
                    name: 'mood[visible]',
                    type: 'switch',
                    value: true,
                    uncheckedValue: false,
                    checked: true
                  },
                  {
                    id: 'submit',
                    type: 'submit',
                    value: 'Submit',
                    dark: true,
                    name: 'commit'
                  }
                ],
                action: '/moods/quick_create'
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
                    dark: true,
                    name: 'commit'
                  }
                ],
                action: '/strategies/quick_create'
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
              id: 'moment_bookmarked',
              checked: false,
              dark: true,
              info: 'Bookmarked moments appear in your Care Plan',
              label: 'Bookmark this moment?',
              name: 'moment[bookmarked]',
              type: 'switch',
              uncheckedValue: false,
              value: true
            },
            {
              id: 'moment_resource_recommendations',
              type: 'switch',
              name: 'moment[resource_recommendations]',
              label: 'Display Resource Recommendations?',
              value: true,
              uncheckedValue: false,
              checked: false,
              dark: true
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
              dark: true,
              name: 'commit'
            }
          ],
          action: '/moments/test-moment'
        )
      end
    end
  end

  private

  def allow_to_receive(method, result)
    allow_any_instance_of(MomentsFormHelper).to receive(method).and_return(result)
  end
end
