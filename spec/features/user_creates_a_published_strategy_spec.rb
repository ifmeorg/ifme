# frozen_string_literal: true

feature 'UserCreatesAPublishedStrategy', type: :feature, js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, user_id: user.id }

  feature 'Creating, viewing, and editing a strategy' do
    scenario 'is not successful' do
      user.confirm if user.respond_to?(:confirm)
      login_as user
      visit new_strategy_path
      expect(page).to have_content 'New Strategy'
      find('#submit').click
      expect(page).to have_content('New Strategy')
      expect(page).to have_css('.labelError')
    end

    scenario 'is successful' do
      user.confirm if user.respond_to?(:confirm)
      login_as user
      visit strategies_path

      expect(page).to have_selector('.pageTitle', text: 'Strategies')
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
        tag_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, tag_input)
          arguments[0].focus();
          arguments[0].value = 'Test Category';
          arguments[0].dispatchEvent(new Event('change', { bubbles: true }));
          arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
          arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
        JS
      end

      if page.has_css?('.modal')
        within '.modal' do
          find('#submit').click
        end
        expect(page).to have_no_css('.modal')
      end

      within('#strategy_category_accordion') do
        expect(page).to have_text(:all, 'Test Category')
      end

      within('#strategy_category_accordion') do
        tag_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, tag_input)
          arguments[0].focus();
          arguments[0].value = 'Some New Category';
          arguments[0].dispatchEvent(new Event('change', { bubbles: true }));
          arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
          arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
        JS
      end

      if page.has_css?('.modal')
        within '.modal' do
          find('#submit').click
        end
        expect(page).to have_no_css('.modal')
      end

      within('#strategy_category_accordion') do
        expect(page).to have_text(:all, 'Some New Category')
      end

      within('#strategy_viewers_accordion') do
        find('.accordion').click
        ['Ally 0', 'Ally 1', 'Ally 2'].each do |ally_name|
          viewer_input = find('input.tagAutocomplete', visible: :all)
          execute_script(<<~JS, viewer_input)
            arguments[0].focus();
            arguments[0].value = '#{ally_name}';
            arguments[0].dispatchEvent(new Event('change', { bubbles: true }));
            arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
            arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
          JS
        end
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
      expect(page).to have_content 'Ally 0, Ally 1, and Ally 2'
      expect(page).to have_content 'Daily reminder email'
      expect(page).to have_css('#comments')
      expect(page).not_to have_selector '.storyDraft'
      find('.storyActionsVisible').hover
      expect(page).to have_content 'Visible in stats'

      # EDITING
      find('.storyActionsEdit').click
      expect(find('.pageTitle')).to have_content 'Edit My New Strategy'

      within('#strategy_category_accordion') do
        expect(page).to have_content 'Test Category'
        expect(page).to have_content 'Some New Category'
        find('.accordion').click
      end

      within('#strategy_viewers_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Ally 0'
        expect(page).to have_content 'Ally 1'
        expect(page).to have_content 'Ally 2'
        find('.accordion').click
      end

      strategy_description_text = 'I am changing my strategy description'
      fill_in_textarea(strategy_description_text, '#strategy_description')
      find('#submit').click

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My New Strategy'
      expect(page).to have_content strategy_description_text
    end
  end
end
