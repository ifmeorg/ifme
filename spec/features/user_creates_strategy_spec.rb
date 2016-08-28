describe "UserCreatesAStrategy", js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, userid: user.id }

  feature 'Creating, viewing, and editing a strategy' do
    it 'is successful' do
      login_as user
      visit strategies_path

      within '#page_title_content' do
        expect(page).to have_content 'Strategies'
      end

      expect(page).to have_content 'Strategize self-care to achieve desired thoughts and attitudes towards your moments.'
      expect(page).to have_content "You haven't created any custom strategies yet."
      expect(page).to have_content 'Five Minute Meditation'

      #CREATING
      page.find('a[title="New Strategy"]').click

      within '#page_title_content' do
        expect(page).to have_content 'New Strategy'
      end

      page.fill_in "strategy[name]", with: "My new strategy"

      page.find('#showCategories').click

      within '#categories_list' do
        page.find('input[type=checkbox]').click
      end

      page.find('#showViewers').click
      within '#viewers_list' do
        page.find('input#viewers_all').click
      end

      # allow comments
      page.find('input#strategy_comment').click

      fill_in_ckeditor('strategy_description', with: 'my strategy description')

      page.find('input[value="Create Strategy"]').click

      # VIEWING
      within '#page_title_content' do
        expect(page).to have_content 'My new strategy'
      end
      expect(page).to have_content 'Created:'
      expect(page).to have_content 'Category: Test Category'
      expect(page).to have_content 'my strategy description'
      expect(page).to have_content 'Ally 0, Ally 1, and Ally 2 are viewers. '
      expect(page).to have_css('#new_comment')

      #EDITING
      page.find('a[title="Edit Strategy"]').click
      within '#page_title_content' do
        expect(page).to have_content 'Edit My new strategy'
      end

      fill_in_ckeditor('strategy_description', with: 'I am changing my strategy description')

      page.find('input[value="Update Strategy"]').click

      #VIEWING AFTER EDITING
      within '#page_title_content' do
        expect(page).to have_content 'My new strategy'
      end
      expect(page).to have_content 'I am changing my strategy description'
    end
  end
end
