# frozen_string_literal: true

describe 'UserCreatesADraftStrategy', js: true do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.first }
  let!(:category) { create :category, user_id: user.id }

  def hit_down_arrow
    keypress = 'var e = $.Event("keydown", { keyCode: 40 }); $("body").trigger(e);'
    page.driver.execute_script(keypress)
  end

  feature 'Creating, viewing, and editing a strategy' do
    it 'is not successful' do
      login_as user
      visit new_strategy_path
      click_on 'Submit'
      expect(page).to have_content('New Strategy')
      expect(page).to have_css('label.alertText')
    end

    it 'is successful' do
      login_as user
      visit strategies_path

      within '.pageTitle' do
        expect(page).to have_content 'Strategies'
      end

      expect(page).to have_content(
        'Strategize self-care to achieve desired thoughts and attitudes ' \
        'towards your moments.'
      )
      expect(page).to have_content(
        "You haven't created any custom strategies yet."
      )
      expect(page).to have_content 'Five Minute Meditation'

      # CREATING
      click_link('New Strategy')

      within '.pageTitle' do
        expect(page).to have_content 'New Strategy'
      end

      page.fill_in 'strategy[name]', with: 'My new strategy'

      page.find('[data-toggle="#categories"]').click
      within '#categories' do
        page.fill_in 'strategy[category_name]', with: 'Test Category'
        hit_down_arrow
        page.find('#strategy_category_name').native.send_keys(:return)
        page.fill_in 'strategy[category_name]', with: 'Some New Category'
        page.find('#strategy_category_name').native.send_keys(:return)
      end
      within '#category_quick_create' do
        page.find('#new_category input[type="submit"]').click
      end
      within '#categories' do
        page.fill_in 'strategy[category_name]', with: 'Another New Category'
        page.find('#strategy_category_name').native.send_keys(:return)
      end
      within '#category_quick_create' do
        page.find('#new_category input[type="submit"]').click
      end
      within '#categories_list' do
        page.all('input[name="strategy[category][]"]')[2].click
      end
      page.find('[data-toggle="#categories"]').click

      page.find('[data-toggle="#viewers"]').click
      within '#viewers_list' do
        page.find('input#viewers_all').click
      end
      page.find('[data-toggle="#viewers"] .toggle_button').click

      # ALLOW COMMENTS
      page.find('input#strategy_comment').click

      fill_in_ckeditor('strategy_description', with: 'my strategy description')

      # SAVE AS DRAFT
      page.find('input[value="Submit"]').click

      # VIEWING
      within '.pageTitle' do
        expect(page).to have_content 'My new strategy'
      end
      expect(page).to have_selector 'span.draftBadge'
      back = current_url

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      within '.pageTitle' do
        expect(page).not_to have_content 'My new strategy'
      end

      login_as user
      visit back

      # EDITING
      click_link('Edit Strategy')
      within '.pageTitle' do
        expect(page).to have_content 'Edit My new strategy'
      end

      fill_in_ckeditor(
        'strategy_description', with: 'I am changing my strategy description'
      )

      # PUBLISH
      scroll_to_and_click('input#togBtn')

      page.find('input[value="Submit"]').click

      # VIEWING AFTER EDITING
      within '.pageTitle' do
        expect(page).to have_content 'My new strategy'
      end
      expect(page).not_to have_selector 'span.draftBadge'

      # TRYING TO VIEW AS ALLY
      login_as ally
      visit back
      within '.pageTitle' do
        expect(page).to have_content 'My new strategy'
      end
    end
  end
end
