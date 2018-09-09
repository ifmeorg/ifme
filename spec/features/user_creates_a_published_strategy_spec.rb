# frozen_string_literal: true

describe 'UserCreatesAPublishedStrategy', js: true do
  let(:user) { create :user2, :with_allies }
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

      expect(find('.pageTitle')).to have_content 'Strategies'
      expect(page).to have_content(
        'Strategize self-care to achieve desired thoughts and attitudes ' \
        'towards your moments.')
      expect(page).to have_content(
        "You haven't created any custom strategies yet.")
      expect(page).to have_content 'Five Minute Meditation'

      # CREATING
      click_link('New Strategy')
      expect(find('.pageTitle')).to have_content 'New Strategy'

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
        page.all('input[name="strategy[category][]"]').last.click
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

      change_page(
        ->{ page.find('input[value="Submit"]').click },
        '.pageTitle', have_content('My new strategy')
      )

      # VIEWING
      expect(page).to have_content 'Created'
      expect(page).to have_content 'Categories: Another New Category, Some New Category'
      expect(page).to have_content 'my strategy description'
      expect(page).to have_content 'Ally 0, Ally 1, and Ally 2 are viewers. '
      expect(page).to have_css('#new_comment')

      # EDITING
      change_page(
        ->{ click_link('Edit Strategy') },
        '.pageTitle',
        have_content('Edit My new strategy')
      )

      fill_in_ckeditor(
        'strategy_description', with: 'I am changing my strategy description'
      )

      page.find('input[value="Submit"]').click

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My new strategy'
      expect(page).to have_content 'I am changing my strategy description'
    end
  end
end
