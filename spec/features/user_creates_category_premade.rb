describe "UserCreatesCategoryPremade", js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, userid: user.id }

  feature 'Category Premade content' do
    context 'when a user visit category index' do
      it 'displays a preview of category content' do
        login_as user
        visit categories_path

        expect(page).to have_css('.page','.category')

        within '.category' do
          expect(page).to have_css('.category_name')
        end
      end
    end

    context 'when a user visits new category path' do
      it 'displays an add premade content button' do
        login_as user
        visit new_category_path

        expect(page).to have_css('button#myBtn.align_right')
      end
    end

    context 'when a user previews and adds a category premade content' do
      it 'displays premade content in a modal box with an add premade button' do
        login_as user
        visit new_category_path

        click_button('Add Premade Content')

        expect(page).to have_css('.modal-content')
        expect(page).to have_css('.category.premade-box')

        within(:css, '.modal-content') do
          click_button('Add Premade Content')
        end

        expect(page).to have_css('.category_name')
        expect(page).to have_content 'Family'
        expect(page).to have_content  'Friends'
      end
    end
  end
end