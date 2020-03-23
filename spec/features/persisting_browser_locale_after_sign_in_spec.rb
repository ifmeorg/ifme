# frozen_string_literal: true
feature 'Persisting browser locale after sign in', type: :feature do
  scenario 'When user sign in, sign out, then change local', js: true, header: true do
    user = create :user

    login_as user
    visit moments_path

    expect(find('.subtitle')).to have_content(
      'Delve deep into your moments - events and situations that affect ' \
      'your mental health.'
    )

    open_header_if_hidden

    within('#header') { find('a[href="/users/sign_out"]').click }

    open_header_if_hidden

    expect(find('#header')).to have_content(/sign in/i)

    change_language('es')

    login_as user
    visit moments_path

    expect(find('.subtitle')).to have_content(
      'Profundiza en tus Momentos - eventos y situaciones que afectan tu ' \
      'salud mental'
    )
  end
end
