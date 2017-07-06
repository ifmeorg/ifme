describe "UserCreatesStrategyPremadetrategy", js: true do
  let(:user) { create :user2, :with_allies }
  let!(:category) { create :category, userid: user.id }

  feature 'Strategy Premade content' do
    context 'when a user visit startegies index' do
      it 'displays a preview of premade content' do
        login_as user
        visit strategies_path

        expect(page).to have_css('.strategy.no_margin_bottom')

        within '.strategy.no_margin_bottom' do
          expect(page).to have_css('.strategy_name')
        end
      end
    end

    context 'when a user visit new startegies path' do
      it 'displays an add premade content button' do
        login_as user
        visit new_strategy_path

        expect(page).to have_css('button#myBtn.actions.align_right')
      end
    end

    context 'when a user previews and adds a premade content' do
      it 'displays premade content in a modal box with an add premade button' do
        login_as user
        visit new_strategy_path

        click_button('Add Premade Content')

        expect(page).to have_css('.modal-content')
        expect(page).to have_css('.strategy.no_margin_bottom.premade-box')

        within(:css, '.strategy.no_margin_bottom.premade-box') do
          click_button('Add Premade Content')
        end

        expect(page).to have_css('.strategy_name')
        expect(page).to have_content 'Five Minute Meditation'
        expect(page).to have_content  'Family'
      end
    end
  end
end
