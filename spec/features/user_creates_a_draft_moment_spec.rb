# frozen_string_literal: true

describe 'UserCreatesADraftMoment', js: true do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.second }
  let!(:category) { create :category, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id }
  let!(:strategy) { create :strategy, user_id: user.id }

  feature 'Creating, viewing, and editing a draft moment' do
    it 'is not successful' do
      login_as user
      visit new_moment_path
      find('#submit').click
      expect(page).to have_content('New Moment')
      expect(page).to have_css('.labelError')
    end

    it 'is successful' do
      login_as user
      visit moments_path
      expect(find('.pageTitle')).to have_content 'Moments'
      expect(page).to have_content 'Delve deep into your moments - events ' \
                                   'and situations that affect your mental ' \
                                   'health.'
      expect(page).to have_content "You haven't written about any moments yet."
      expect(page).to have_content 'Panicking over interview tomorrow!'

      # CREATING
      click_link('New Moment')
      expect(find('.pageTitle')).to have_content 'New Moment'
      find('#moment_name').set('My New Moment')
      fill_in_textarea('A moment why', '#moment_why')

      within('#moment_category_accordion') do
        find('.accordion').click
        find('.tagAutocomplete').set('Test Category')
        page.find('.tagAutocomplete').native.send_keys(:return)
        find('.tagAutocomplete').set('Some New Category')
        page.find('.tagAutocomplete').native.send_keys(:return)
      end

      within '.modal' do
        find('#submit').click
      end

      within('#moment_category_accordion') do
        find('.accordion').click
      end

      within('#moment_mood_accordion') do
        find('.accordion').click
        find('.tagAutocomplete').set('Test Mood')
        page.find('.tagAutocomplete').native.send_keys(:return)
        find('.tagAutocomplete').set('Some New Mood')
        page.find('.tagAutocomplete').native.send_keys(:return)
      end

      within '.modal' do
        find('#submit').click
      end

      within('#moment_mood_accordion') do
        find('.accordion').click
      end

      within('#moment_strategy_accordion') do
        find('.accordion').click
        find('.tagAutocomplete').set('Test Strategy')
        page.find('.tagAutocomplete').native.send_keys(:return)
        find('.tagAutocomplete').set('Some New Strategy')
        page.find('.tagAutocomplete').native.send_keys(:return)
      end

      within '.modal' do
        fill_in_textarea('A Strategy Description', '#strategy_description')
        find('#submit').click
      end

      within('#moment_viewers_accordion') do
        find('.accordion').click
        find('.tagAutocomplete').set('Ally 1')
        page.find('.tagAutocomplete').native.send_keys(:return)
        find('.accordion').click
      end

      find('#moment_comment_switch').click
      find('#submit').click

      # VIEWING AS OWNER
      expect(find('.pageTitle')).to have_content 'My New Moment'
      expect(page).to have_content 'Test Category'.upcase
      expect(page).to have_content 'Some New Category'.upcase
      expect(page).to have_content 'Test Mood'.upcase
      expect(page).to have_content 'Some New Mood'.upcase
      expect(page).to have_content 'What happened and how do you feel?'.upcase
      expect(page).to have_content 'A moment why'
      expect(page).to have_content 'What strategies would help?'.upcase
      expect(page).to have_content 'Test Strategy'
      expect(page).to have_content 'Some New Strategy'
      find('.storyActionsViewers').hover
      expect(page).to have_content 'Ally 1'
      expect(page).not_to have_css('#comments')
      expect(page).to have_selector '.storyDraft'
      back = current_url

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      expect(find('.pageTitle')).not_to have_content 'My New Moment'
      login_as user
      visit back

      # EDITING
      find('.storyActionsEdit').click
      expect(find('.pageTitle')).to have_content 'Edit My New Moment'

      within('#moment_category_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Test Category'
        expect(page).to have_content 'Some New Category'
        find('.accordion').click
      end

      within('#moment_mood_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Test Mood'
        expect(page).to have_content 'Some New Mood'
        find('.accordion').click
      end

      within('#moment_strategy_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Test Strategy'
        expect(page).to have_content 'Some New Strategy'
        find('.accordion').click
      end

      within('#moment_viewers_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Ally 1'
        find('.accordion').click
      end

      moment_why_text = 'I am changing my moment why'
      fill_in_textarea(moment_why_text, '#moment_why')

      # PUBLISH
      find('#moment_publishing_switch').click
      find('#submit').click

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My New Moment'
      expect(page).to have_content moment_why_text
      expect(page).not_to have_selector '.storyDraft'
      expect(page).to have_css('#comments')

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      expect(find('.pageTitle')).to have_content 'My New Moment'
      expect(page).to have_content moment_why_text
    end
  end
end
