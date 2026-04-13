# frozen_string_literal: true

require 'spec_helper'

describe MomentsFormHelper, type: :helper do
  let(:user) { create(:user2, :with_allies) }
  let(:viewers) { user.allies }
  let(:category) { create(:category, user_id: user.id) }
  let(:mood) { create(:mood, user_id: user.id) }
  let(:strategy) { create(:strategy, user_id: user.id) }

  before do
    @viewers = viewers
    @categories = user.categories
    @moods = user.moods
    @strategies = user.strategies

    params[:controller] = 'moments'

    allow(helper).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(helper).to receive(:params).and_return(params)
  end

  describe '#new_moment_props' do
    let(:moment) { Moment.new }

    before do
      @moment = moment
      @category = Category.new
      @mood = Mood.new
      @strategy = Strategy.new

      allow(helper).to receive(:action_name).and_return('create')
      allow(controller).to receive(:action_name).and_return('create')
    end

    subject { helper.new_moment_props.deep_symbolize_keys }

    context 'when there are no moment templates' do
      it 'returns the correct base action and main inputs' do
        # Verify the top-level keys first
        expect(subject[:action]).to eq('/moments')
        
        # Verify specific critical inputs exist using matchers
        expect(subject[:inputs]).to include(
          hash_including(id: 'moment_name', name: 'moment[name]', type: 'text'),
          hash_including(id: 'moment_why', type: 'textareaTemplate'),
          hash_including(id: 'moment_category', type: 'quickCreate'),
          hash_including(id: 'submit', type: 'submit', value: 'Submit')
        )
      end

      it 'correctly maps the viewers to the tag input' do
        viewer_input = subject[:inputs].find { |i| i[:id] == 'moment_viewers' }
        
        expect(viewer_input[:checkboxes].size).to eq(viewers.size)
        expect(viewer_input[:checkboxes]).to include(
          hash_including(label: viewers.first.name, value: viewers.first.id)
        )
      end

      it 'sets default switch values correctly' do
        comment_switch = subject[:inputs].find { |i| i[:id] == 'moment_comment' }
        expect(comment_switch[:value]).to be true
        
        draft_switch = subject[:inputs].find { |i| i[:id] == 'moment_publishing' }
        expect(draft_switch[:value]).to eq('0')
      end
    end

    context 'when there are moment templates' do
      # Ensure the name is consistent for the ID generation logic
      let!(:moment_template) do 
        create(:moment_template, 
               user_id: user.id, 
               name: 'Test Template', 
               description: 'Test Description') 
      end

      it 'returns correct props including templates in the options' do
        why_input = subject[:inputs].find { |i| i[:id] == 'moment_why' }
        
        # We use matchers to check the values we care about.
        # Based on your output, the ID is derived from the name.
        expect(why_input[:options]).to include(
          hash_including(
            id: moment_template.name.parameterize,
            label: moment_template.name,
            value: moment_template.description,
            selected: false
          )
        )
      end
    end
  end

  describe '#edit_moment_props' do
    let(:moment) { create(:moment, user: user, category: [category.id], mood: [mood.id], strategy: [strategy.id], resource_recommendations: false) }

    before do
      @moment = moment
      @category = category
      @mood = mood
      @strategy = strategy

      allow(helper).to receive(:action_name).and_return('edit')
      allow(controller).to receive(:action_name).and_return('edit')
    end

    subject { helper.edit_moment_props.deep_symbolize_keys }

    it 'returns correct props for the edit form' do
      expect(subject[:action]).to eq("/moments/#{moment.to_param}")

      # Verify method override for PATCH
      expect(subject[:inputs]).to include(hash_including(id: '_method', value: 'patch'))

      # Verify value persistence
      name_input = subject[:inputs].find { |i| i[:id] == 'moment_name' }
      expect(name_input[:value]).to eq(moment.name)

      resource_switch = subject[:inputs].find { |i| i[:id] == 'moment_resource_recommendations' }
      expect(resource_switch[:checked]).to be false
    end
  end
end