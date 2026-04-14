# frozen_string_literal: true

feature 'UserCreatesAPublishedMoment', type: :feature, js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id }
  let!(:strategy) { create :strategy, user_id: user.id }

  feature 'Creating, viewing, and editing a moment' do
    scenario 'is not successful' do
      user.confirm if user.respond_to?(:confirm)
      login_as user
      visit new_moment_path
      expect(page).to have_content 'New Moment'
      find('#submit').click
      expect(page).to have_content('New Moment')
      expect(page).to have_css('.labelError')
    end

    scenario 'is successful' do
      user.confirm if user.respond_to?(:confirm)
      login_as user
      visit moments_path
      expect(page).to have_selector('.pageTitle', text: 'Moments')
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

      within('#moment_category_accordion') do
        expect(page).to have_text(:all, 'Test Category')
      end

      within('#moment_category_accordion') do
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

      within('#moment_category_accordion') do
        expect(page).to have_text(:all, 'Some New Category')
      end

      within('#moment_category_accordion') do
        find('.accordion').click
      end

      within('#moment_mood_accordion') do
        find('.accordion').click
        tag_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, tag_input)
          arguments[0].focus();
          arguments[0].value = 'Test Mood';
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

      within('#moment_mood_accordion') do
        expect(page).to have_text(:all, 'Test Mood')
      end

      within('#moment_mood_accordion') do
        tag_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, tag_input)
          arguments[0].focus();
          arguments[0].value = 'Some New Mood';
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

      within('#moment_mood_accordion') do
        expect(page).to have_text(:all, 'Some New Mood')
      end

      within('#moment_mood_accordion') do
        find('.accordion').click
      end

      within('#moment_strategy_accordion') do
        find('.accordion').click
        tag_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, tag_input)
          arguments[0].focus();
          arguments[0].value = 'Test Strategy';
          arguments[0].dispatchEvent(new Event('change', { bubbles: true }));
          arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
          arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
        JS
      end

      if page.has_css?('.modal')
        within '.modal' do
          fill_in_textarea('A Strategy Description', '#strategy_description')
          find('#submit').click
        end
        expect(page).to have_no_css('.modal')
      end

      within('#moment_strategy_accordion') do
        expect(page).to have_text(:all, 'Test Strategy')
      end

      within('#moment_strategy_accordion') do
        tag_input = find('input.tagAutocomplete', visible: :all)
        execute_script(<<~JS, tag_input)
          arguments[0].focus();
          arguments[0].value = 'Some New Strategy';
          arguments[0].dispatchEvent(new Event('change', { bubbles: true }));
          arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
          arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
        JS
      end

      if page.has_css?('.modal')
        within '.modal' do
          fill_in_textarea('A Strategy Description', '#strategy_description')
          find('#submit').click
        end
        expect(page).to have_no_css('.modal')
      end

      within('#moment_strategy_accordion') do
        expect(page).to have_text(:all, 'Some New Strategy')
      end

      within('#moment_viewers_accordion') do
        find('.accordion').click
        ['Ally 0', 'Ally 1', 'Ally 2'].each do |ally_name|
          viewer_input = find('input.tagAutocomplete', visible: :all)
          execute_script(<<~JS, viewer_input)
            arguments[0].focus();
            arguments[0].value = '#{ally_name}';
            arguments[0].dispatchEvent(new Event('input', { bubbles: true }));
            arguments[0].dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', keyCode: 13, bubbles: true }));
          JS
        end
        find('.accordion').click
      end

      find('#moment_comment_switch').click
      find('#submit').click

      # VIEWING
      expect(find('.pageTitle')).to have_content 'My New Moment'
      expect(page).to have_content 'Test Category'.upcase
      expect(page).to have_content 'Some New Category'.upcase
      expect(page).to have_content 'Test Mood'.upcase
      expect(page).to have_content 'Some New Mood'.upcase
      expect(page).to have_content 'A moment why'
      expect(page).to have_content 'What strategies would help?'.upcase
      expect(page).to have_content 'Test Strategy'
      expect(page).to have_content 'Some New Strategy'
      find('.storyActionsViewers').hover
      expect(page).to have_content 'Ally 0, Ally 1, and Ally 2'
      expect(page).to have_css('#comments')
      expect(page).not_to have_selector '.storyDraft'

      # EDITING
      find('.storyActionsEdit').click
      expect(find('.pageTitle')).to have_content 'Edit My New Moment'

      within('#moment_category_accordion') do
        expect(page).to have_content 'Test Category'
        expect(page).to have_content 'Some New Category'
        find('.accordion').click
      end

      within('#moment_mood_accordion') do
        expect(page).to have_content 'Test Mood'
        expect(page).to have_content 'Some New Mood'
        find('.accordion').click
      end

      within('#moment_strategy_accordion') do
        expect(page).to have_content 'Test Strategy'
        expect(page).to have_content 'Some New Strategy'
        find('.accordion').click
      end

      within('#moment_viewers_accordion') do
        find('.accordion').click
        expect(page).to have_content 'Ally 0'
        expect(page).to have_content 'Ally 1'
        expect(page).to have_content 'Ally 2'
        find('.accordion').click
      end

      moment_why_text = 'I am changing my moment why. I am struggling a lot and sometimes think about dying.'
      fill_in_textarea(moment_why_text, '#moment_why')
      find('#submit').click

      # VIEWING AFTER EDITING
      within('.modal') do
        expect(page).to have_content 'How are you doing?'
        find('.modalClose').click
      end

      expect(find('.pageTitle')).to have_content 'My New Moment'
      expect(page).to have_content moment_why_text
    end
  end
end
