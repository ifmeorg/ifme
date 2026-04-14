# frozen_string_literal: true

feature 'UserCreatesADraftStrategy', type: :feature, js: true do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.second }
  let!(:category) { create :category, user_id: user.id }

  feature 'Creating, viewing, and editing a strategy' do
    scenario 'is successful' do
      user.confirm if user.respond_to?(:confirm)
      login_as user
      visit strategies_path

      expect(page).to have_link('New Strategy')
      click_link('New Strategy')
      find('#strategy_name').set('My New Strategy')
      fill_in_textarea('A strategy description', '#strategy_description')

      # --- CATEGORY 1 ---
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

      # --- CATEGORY 2 ---
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

      # --- VIEWERS SECTION ---
      within('#strategy_viewers_accordion') do
        find('.accordion').click
        viewer_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, viewer_input)
          arguments[0].focus();
          arguments[0].value = 'Ally 1';
          arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
          arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
        JS
      end

      find('#strategy_comment_switch').click
      find('#strategy_perform_strategy_reminder').click
      find('#strategy_publishing_switch').click
      find('#submit').click

      # --- VERIFICATION ---
      expect(page).to have_content 'My New Strategy'

      # Final check: on the show page these are visible and transformed to uppercase
      expect(page).to have_content 'TEST CATEGORY'
      expect(page).to have_content 'SOME NEW CATEGORY'
    end
  end
end