describe 'UserCreatesADraftMoment', js: true do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.first }
  let!(:category) { create :category, user_id: user.id }
  let!(:mood) { create :mood, user_id: user.id }
  let!(:strategy) { create :strategy, user_id: user.id }

  def hit_down_arrow
    page.driver.execute_script(<<~JS)
      var e = $.Event("keydown", { keyCode: 40 });
      $("body").trigger(e);
    JS
  end

  feature 'Creating, viewing, and editing a draft moment' do
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

      within '.pageTitle' do
        expect(page).to have_content 'Moments'
      end

      expect(page).to have_content 'Delve deep into your moments - events ' \
                                   'and situations that affect your mental ' \
                                   'health.'
      expect(page).to have_content "You haven't written about any moments yet."
      expect(page).to have_content 'Panicking over interview tomorrow!'

      # CREATING
      click_link('New Moment')

      within '.pageTitle' do
        expect(page).to have_content 'New Moment'
      end

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
        page.all('input[name="moment[category][]"]')[2].click
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

      # SAVE AS DRAFT


      page.find('input[value="Submit"]').click

      # VIEWING AS OWNER
      within '.pageTitle' do
        expect(page).to have_content 'My new moment'
      end
      expect(page).to have_selector 'span.draftBadge'
      back = current_url

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      within '.pageTitle' do
        expect(page).not_to have_content 'My new moment'
      end

      login_as user
      visit back

      # EDITING
      click_link('Edit Moment')

      within '.pageTitle' do
        expect(page).to have_content 'Edit My new moment'
      end

      moment_why_text = 'I am changing my moment why description'
      fill_in_ckeditor('moment_why', with: moment_why_text)

      # PUBLISH
      scroll_to_and_click('input#togBtn')

      page.find('input[value="Submit"]').click

      # VIEWING AFTER EDITING
      within '.pageTitle' do
        expect(page).to have_content 'My new moment'
      end
      expect(page).not_to have_selector 'span.draftBadge'

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      within '.pageTitle' do
        expect(page).to have_content 'My new moment'
      end
    end
  end
end
