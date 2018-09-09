describe 'UserCreatesAPublishedMoment', js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id }
  let!(:strategy) { create :strategy, user_id: user.id }

  def hit_down_arrow
    page.driver.execute_script(<<~JS)
      var e = $.Event("keydown", { keyCode: 40 });
      $("body").trigger(e);
    JS
  end

  feature 'Creating, viewing, and editing a moment' do
    it 'is not successful' do
      login_as user
      visit new_moment_path
      click_on 'Submit'
      expect(page).to have_content('New Moment')
      expect(page).to have_css('label.alertText')
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
      page.fill_in 'moment[name]', with: 'My new moment'

      page.find('[data-toggle="#categories"]').click

      within '#categories' do
        page.fill_in 'moment[category_name]', with: 'Test Category'
        hit_down_arrow
        page.find('#moment_category_name').native.send_keys(:return)
        page.fill_in 'moment[category_name]', with: 'Some New Category'
        page.find('#moment_category_name').native.send_keys(:return)
      end

      within '#category_quick_create' do
        page.find('#new_category input[type="submit"]').click
      end

      within '#categories' do
        page.fill_in 'moment[category_name]', with: 'Another New Category'
        page.find('#moment_category_name').native.send_keys(:return)
      end

      within '#category_quick_create' do
        page.find('#new_category input[type="submit"]').click
      end

      within '#categories_list' do
        page.all('input[name="moment[category][]"]').last.click
      end

      page.find('[data-toggle="#categories"]').click

      page.find('[data-toggle="#moods"]').click

      within '#moods' do
        page.fill_in 'moment[mood_name]', with: 'Test Mood'
        hit_down_arrow
        page.find('#moment_mood_name').native.send_keys(:return)
        page.fill_in 'moment[mood_name]', with: 'Some New Mood'
        page.find('#moment_mood_name').native.send_keys(:return)
      end

      within '#mood_quick_create' do
        page.find('#new_mood input[type="submit"]').click
      end

      within '#moods_list' do
        page.all('input[name="moment[mood][]"]')[0].click
      end

      within '#moods' do
        page.fill_in 'moment[mood_name]', with: 'Another New Mood'
        page.find('#moment_mood_name').native.send_keys(:return)
      end

      within '#mood_quick_create' do
        page.find('#new_mood input[type="submit"]').click
      end

      page.find('[data-toggle="#moods"]').click

      scroll_to_and_click('[data-toggle="#strategies"]')

      within '#strategies' do
        page.fill_in 'moment[strategy_name]', with: 'Test Strategy'
        hit_down_arrow
        page.find('#moment_strategy_name').native.send_keys(:return)
        page.fill_in 'moment[strategy_name]', with: 'Some New Strategy'
        page.find('#moment_strategy_name').native.send_keys(:return)
      end

      within '#strategy_quick_create' do
        page.fill_in 'strategy[description]', with: 'Hello some description'
        scroll_to_and_click('#new_strategy input[type="submit"]')
      end

      scroll_to_and_click('[data-toggle="#strategies"]')
      scroll_to_and_click('[data-toggle="#viewers"]')

      within '#viewers_list' do
        scroll_to_and_click('#viewers_all')
      end

      scroll_to_and_click('[data-toggle="#viewers"]')

      # ALLOW COMMENTS
      scroll_to_and_click('input#moment_comment')

      fill_in_ckeditor('moment_why', with: 'my moment why description')
      fill_in_ckeditor('moment_fix', with: 'my moment fix description')

      page.find('input[value="Submit"]').click

      # VIEWING
      expect(find('.pageTitle')).to have_content 'My new moment'

      expect(page).to have_content 'Created'
      expect(page).to have_content 'Categories: Another New Category, ' \
                                   'Some New Category'
      expect(page).to have_content 'Moods: Another New Mood, Test Mood'
      expect(page).to have_content 'What happened and how do you feel?'.upcase
      expect(page).to have_content 'my moment why description'
      expect(page).to have_content 'What thoughts would you like to have?'.upcase
      expect(page).to have_content 'my moment fix description'
      expect(page).to have_content 'What strategies would help?'.upcase
      expect(page).to have_content 'Some New Strategy, Test Strategy'
      expect(page).to have_content 'Ally 0, Ally 1, and Ally 2 are viewers. '
      expect(page).to have_css('#new_comment')

      # EDITING
      click_link('Edit Moment')
      expect(find('.pageTitle')).to have_content 'Edit My new moment'

      moment_why_text = 'I am changing my moment why description'
      fill_in_ckeditor('moment_why', with: moment_why_text)

      page.find('input[value="Submit"]').click

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My new moment'
      expect(page).to have_content moment_why_text
    end
  end
end