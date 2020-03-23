describe 'Load more resources', js: true do
  let(:user) { create :user }
  feature 'load more feature' do
    context 'clicking the load more button' do
      before :each do
        visit('/resources')
      end

      it 'loads 12 resources on page load' do
        expect(page).to have_text '12 of'
        expect(page).to have_selector('.Resource', count: 12)
        expect(page).to have_button('Load more')
      end

      it 'loads 36 resources after clicking load more button twice' do
        2.times do
          click_button('Load more')
        end

        expect(page).to have_text '36 of'
        expect(page).to have_selector('.Resource', count: 36)
      end
    end
  end
end
