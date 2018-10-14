# frozen_string_literal: true

describe 'UserCreatesADraftStrategy', js: true do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.second }
  let!(:category) { create :category, user_id: user.id }

  feature 'Creating, viewing, and editing a strategy' do
    it 'is not successful' do
      login_as user
      visit new_strategy_path
      find('#submit').click
      expect(page).to have_content('New Strategy')
      expect(page).to have_css('.labelError')
    end

    it 'is successful' do
      login_as user
      visit strategies_path

      expect(find('.pageTitle')).to have_content 'Strategies'
      expect(page).to have_content(
        'Strategize self-care to achieve desired thoughts and attitudes ' \
        'towards your moments.'
      )
      expect(page).to have_content(
        'You haven\'t created any custom strategies yet.'
      )
      expect(page).to have_content 'Five Minute Meditation'

      # CREATING
      click_link('New Strategy')
      expect(find('.pageTitle')).to have_content 'New Strategy'
      find('#strategy_name').set('My New Strategy')
      fill_in_textarea('A strategy description', '#strategy_description')

      within('#strategy_category_accordion') do
        find('.accordion').click
        find('.tagAutocomplete').set('Test Category')
        page.find('.tagAutocomplete').native.send_keys(:return)
        find('.tagAutocomplete').set('Some New Category')
        page.find('.tagAutocomplete').native.send_keys(:return)
      end

      within '.modal' do
        find('#submit').click
      end

      within('#strategy_viewers_accordion') do
        find('.accordion').click
        find('.tagAutocomplete').set('Ally 1')
        page.find('.tagAutocomplete').native.send_keys(:return)
        find('.accordion').click
      end

      find('#strategy_comment_switch').click
      find('#strategy_perform_strategy_reminder').click
      find('#submit').click

      # VIEWING
      expect(find('.pageTitle')).to have_content 'My New Strategy'
      expect(page).to have_content 'Test Category'.upcase
      expect(page).to have_content 'Some New Category'.upcase
      expect(page).to have_content 'A strategy description'
      find('.storyActionsViewers').hover
      expect(page).to have_content 'Ally 1'
      expect(page).to have_content 'Daily reminder email'
      expect(page).not_to have_css('#comments')
      expect(page).to have_selector '.storyDraft'
      back = current_url

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      expect(find('.pageTitle')).not_to have_content 'My New Strategy'

      # EDITING
      login_as user
      visit back
      find('.storyActionsEdit').click
      expect(find('.pageTitle')).to have_content 'Edit My New Strategy'

      within('#strategy_category_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Test Category'
        expect(page).to have_content 'Some New Category'
        find('.accordion').click
      end

      within('#strategy_viewers_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Ally 1'
        find('.accordion').click
      end

      strategy_description_text = 'I am changing my strategy description'
      fill_in_textarea(strategy_description_text, '#strategy_description')

      # PUBLISH
      find('#strategy_publishing_switch').click
      find('#submit').click

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My New Strategy'
      expect(page).to have_content strategy_description_text
      expect(page).not_to have_selector '.storyDraft'
      expect(page).to have_css('#comments')

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      expect(find('.pageTitle')).to have_content 'My New Strategy'
      expect(page).to have_content strategy_description_text
    end
  end
end
