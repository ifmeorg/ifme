RSpec.feature 'ModalEditor', type: :feature, js: true do
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

  feature 'Creating/editing a moment on mobile' do
    scenario 'successfully' do
      # Mobile viewport behaviour testing ahead
      window = Capybara.current_session.driver.browser.manage.window
      window.resize_to(480, 620)

      login_as user
      visit new_moment_path

      # CREATING
      expect(find('.pageTitle')).to have_content 'New Moment'
      page.fill_in 'moment[name]', with: 'My new moment'

      # ONLY TESTING THE MODAL'S BEHAVIOUR
      # Focusing on the why field opens the modal editor
      page.find('#cke_moment_why').click
      fill_in_ckeditor('modal_editor', with: 'my moment why description')

      # Modal is closed
      page.find('#close_editor').click

      # Focusing on the fix field opens the modal editor too
      page.find('#cke_moment_fix').click
      fill_in_ckeditor('modal_editor', with: 'my moment fix description')

      # Modal is closed again
      page.find('#close_editor').click

      page.find('input[value="Submit"]').click

      # VIEWING
      expect(find('.pageTitle')).to have_content 'My new moment'
      expect(page).to have_content 'my moment why description'
      expect(page).to have_content 'my moment fix description'


      # EDITING
      click_link('Edit Moment')
      expect(find('.pageTitle')).to have_content 'Edit My new moment'

      moment_why_text = 'I am changing my moment why description'
      moment_fix_text = 'I am changing my moment fix description'

      # ONLY TESTING THE MODAL'S BEHAVIOUR
      page.find('#cke_moment_why').click
      fill_in_ckeditor('modal_editor', with: moment_why_text)

      page.find('#close_editor').click

      page.find('#cke_moment_fix').click
      fill_in_ckeditor('modal_editor', with: moment_fix_text)

      page.find('#close_editor').click

      page.find('input[value="Submit"]').click

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My new moment'

      # RESTORE WINDOW SIZE
      window.resize_to(1280, 1024)

      expect(page).to have_content moment_why_text
      expect(page).to have_content moment_fix_text
    end
  end

  feature 'Creating/editing a strategy on mobile' do
    scenario 'successfully' do
      # Mobile viewport behaviour testing ahead
      window = Capybara.current_session.driver.browser.manage.window
      window.resize_to(480, 620)

      login_as user
      visit new_strategy_path

      # CREATING
      expect(find('.pageTitle')).to have_content 'New Strategy'
      page.fill_in 'strategy[name]', with: 'My new strategy'

      # ONLY TESTING THE MODAL'S BEHAVIOUR
      # Focusing on the why field opens the modal editor
      page.find('#cke_strategy_description').click
      fill_in_ckeditor('modal_editor', with: 'my strategy description')

      # Modal is closed
      page.find('#close_editor').click

      page.find('input[value="Submit"]').click

      # VIEWING
      expect(find('.pageTitle')).to have_content 'My new strategy'
      expect(page).to have_content 'my strategy description'

      # EDITING
      click_link('Edit Strategy')
      expect(find('.pageTitle')).to have_content 'Edit My new strategy'
      strategy_text = 'I am changing my strategy description'

      # ONLY TESTING THE MODAL'S BEHAVIOUR
      page.find('#cke_strategy_description').click
      fill_in_ckeditor('modal_editor', with: strategy_text)

      page.find('#close_editor').click

      page.find('input[value="Submit"]').click

      # RESTORE WINDOW SIZE
      window.resize_to(1280, 1024)

      # VIEWING AFTER EDITING
      expect(find('.pageTitle')).to have_content 'My new strategy'
      expect(page).to have_content strategy_text
    end
  end
end
