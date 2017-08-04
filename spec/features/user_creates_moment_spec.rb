describe 'UserCreatesAMoment', js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, userid: user.id }
  let!(:mood) { create :mood, userid: user.id }
  let!(:strategy) { create :strategy, userid: user.id }

  def hit_down_arrow
    keypress = "var e = $.Event('keydown', { keyCode: 40 }); $('body').trigger(e);"
    page.driver.execute_script(keypress)
  end

  feature 'Creating, viewing, and editing a moment' do
    it 'is successful' do
      login_as user
      visit moments_path

      within '#page_title_content' do
        expect(page).to have_content 'Moments'
      end

      expect(page).to have_content 'Delve deep into your moments - events and situations that affect your mental health.'
      expect(page).to have_content 'You haven\'t written about any moments yet.'
      expect(page).to have_content 'Panicking over interview tomorrow!'

      #CREATING
      page.find('a[title="New Moment"]').click

      within '#page_title_content' do
        expect(page).to have_content 'New Moment'
      end

      page.fill_in 'moment[name]', with: 'My new moment'

      page.find('[data-toggle="#categories"]').click

      within '#categories' do
        page.fill_in 'moment[category_name]', with: 'Test Category'
        hit_down_arrow
        page.find('#moment_category_name').native.send_keys(:return)
      end

      page.find('[data-toggle="#moods"]').click
      within '#moods' do
        page.fill_in 'moment[mood_name]', with: 'Test Mood'
        hit_down_arrow
        page.find('#moment_mood_name').native.send_keys(:return)
      end

      scroll_to_and_click('[data-toggle="#strategies"]')
      scroll_to_and_click('[data-toggle="#viewers"]')
      within '#strategies' do
        page.fill_in 'moment[strategies_name]', with: 'Test Strategy'
        hit_down_arrow
        page.find('#moment_strategies_name').native.send_keys(:return)
      end

      within '#viewers_list' do
        scroll_to_and_click('input#viewers_all')
      end

      # allow comments
      scroll_to_and_click('input#moment_comment')

      fill_in_ckeditor('moment_why', with: 'my moment why description')
      fill_in_ckeditor('moment_fix', with: 'my moment fix description')

      page.find('input[value="Submit"]').click

      # VIEWING
      within '#page_title_content' do
        expect(page).to have_content 'My new moment'
      end
      expect(page).to have_content 'Created:'
      expect(page).to have_content 'Category: Test Category'
      expect(page).to have_content 'Mood: Test Mood'

      expect(page).to have_content 'What happened and how do you feel?'
      expect(page).to have_content 'my moment why description'

      expect(page).to have_content 'What thoughts would you like to have?'
      expect(page).to have_content 'my moment fix description'

      expect(page).to have_content 'What strategies would help?'
      expect(page).to have_content 'Test Strategy'

      expect(page).to have_content 'Ally 0, Ally 1, and Ally 2 are viewers. '
      expect(page).to have_css('#new_comment')

      #EDITING
      page.find('a[title="Edit Moment"]').click
      within '#page_title_content' do
        expect(page).to have_content 'Edit My new moment'
      end

      fill_in_ckeditor('moment_why', with: 'I am changing my moment why description')

      page.find('input[value="Submit"]').click

      #VIEWING AFTER EDITING
      within '#page_title_content' do
        expect(page).to have_content 'My new moment'
      end
      expect(page).to have_content 'I am changing my moment why description'
    end
  end
end
