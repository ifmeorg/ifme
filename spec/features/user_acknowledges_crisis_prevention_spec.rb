# frozen_string_literal: true

feature 'UserAcknowledgesCrisisPrevention', type: :feature, js: true do
  let(:user) { create :user2 }
  let(:crisis_why) do
    'I am struggling a lot and sometimes think about dying.'
  end
  let!(:moment) do
    create :moment, :with_published_at, user: user, name: 'My Hard Day',
                                        why: crisis_why,
                                        crisis_prevention_acknowledged: false
  end

  before do
    login_as user
  end

  feature 'Viewing a moment with crisis keywords' do
    it 'shows the crisis prevention modal' do
      visit moment_path(moment)
      within('.modal') do
        expect(page).to have_content('How are you doing?')
      end
    end

    it 'dismissing the modal does not persist acknowledgment' do
      visit moment_path(moment)
      within('.modal') do
        find('.modalClose').click
      end
      expect(page).not_to have_selector('.modal')

      # Revisit — modal should reappear since it was only dismissed
      visit moment_path(moment)
      expect(page).to have_selector('.modal')
      expect(moment.reload.crisis_prevention_acknowledged).to be false
    end

    it 'clicking the acknowledge button persists the state and closes the modal' do
      visit moment_path(moment)
      within('.modal') do
        expect(page).to have_content('How are you doing?')
        click_button 'Acknowledged, I am going to tend to my needs.'
      end

      expect(page).not_to have_selector('.modal')

      # Revisit — modal should not reappear
      visit moment_path(moment)
      expect(page).not_to have_selector('.modal')
      expect(moment.reload.crisis_prevention_acknowledged).to be true
    end
  end

  feature 'Editing a moment after acknowledging' do
    let!(:acknowledged_moment) do
      create :moment, :with_published_at, user: user,
                                          name: 'My Acknowledged Moment',
                                          why: crisis_why,
                                          crisis_prevention_acknowledged: true,
                                          crisis_prevention_acknowledged_text: crisis_why
    end

    it 'keeps acknowledgment when the text changes by 30% or less' do
      visit edit_moment_path(acknowledged_moment)
      # Append a few words — small change
      fill_in_textarea("#{crisis_why} Feeling a bit better now.", '#moment_why')
      find('#submit').click

      expect(acknowledged_moment.reload.crisis_prevention_acknowledged).to be true
      expect(page).not_to have_selector('.modal')
    end

    it 'resets acknowledgment when the text changes by more than 30%' do
      visit edit_moment_path(acknowledged_moment)
      fill_in_textarea(
        'I have been thinking about dying every day and cannot stop these dark thoughts.',
        '#moment_why',
      )
      find('#submit').click

      # Modal should now be shown again
      within('.modal') do
        expect(page).to have_content('How are you doing?')
      end
      expect(acknowledged_moment.reload.crisis_prevention_acknowledged).to be false
    end
  end
end
