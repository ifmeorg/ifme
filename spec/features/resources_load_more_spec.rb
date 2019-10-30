describe "Load more resources", js: true do
    let(:user) { create :user }
    feature 'load more feature' do
        context 'clicking the load more button' do
            before :each do
                visit('/resources')
            end

            it "loads 3 resources" do
                expect(page).to have_text '3 of 120 resources'
                expect(page).to have_selector('.Resources__gridThreeItem___1Lm4E', count: 3)
                expect(page).to have_button('Load more')
            end

            it 'loads more resources' do
                2.times do
                    click_button('Load more')
                end

                expect(page).to have_text '9 of 120 resources'
                expect(page).to have_selector('.Resources__gridThreeItem___1Lm4E', count: 9)

            end

            it 'loads all resources and the load more button vanishes' do
                39.times do
                    click_button('Load more')
                end
                expect(page).to have_text '120 of 120 resources'
                expect(page).to have_selector('.Resources__gridThreeItem___1Lm4E', count: 120)
                expect(page).not_to have_button('Load more')
            end
        end
    end
end
