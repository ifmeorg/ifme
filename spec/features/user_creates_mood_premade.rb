describe "UserCreatesMoodPremade", js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, userid: user.id }

  feature 'Mood Premade content' do
    context 'when a user visit mood index' do
      it 'displays a preview of mood content' do
        login_as user
        visit moods_path

        expect(page).to have_css('.mood.no_margin_bottom')

        within '.mood.no_margin_bottom' do
          expect(page).to have_css('.mood_name')
        end
      end
    end

    context 'when a user visit new mood path' do
      it 'displays an add premade content button' do
        login_as user
        visit new_mood_path

        expect(page).to have_css('button#myBtn.align_right')
      end
    end

    context 'when a user previews and adds a mood content' do
      it 'displays premade content in a modal box with an add premade button' do
        login_as user
        visit new_mood_path

        click_button('Add Premade Content')

        expect(page).to have_css('.modal-content')
        expect(page).to have_css('.mood.no_margin_bottom.premade-box')

        within(:css, '.modal-content') do
          click_button('Add Premade Content')
        end

        expect(page).to have_css('.mood_name')
        expect(page).to have_content 'Accepting'
        expect(page).to have_content  'Ambitious'
      end
    end
  end
end