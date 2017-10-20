RSpec.feature 'Persisting browser locale after sign in', type: :feature do
  scenario 'When user sign in, sign out, then change local', js: true do
    user = create :user

    login_as user
    visit moments_path

    expect(page).to have_content('Delve deep into your moments - events and ' \
                                 'situations that affect your mental health.')

    within('span#title_expand') { find('i.expand').click }
    within('ul#expand_me') { find('a[href="/users/sign_out"]').click }
    expect(find('a[href="/users/sign_in"]')).to have_content('Sign in')
    select 'Español', from: 'locale'
    expect(find('a[href="/users/sign_in"]')).to have_content('Ingresar')

    login_as user
    visit moments_path

    expect(page).to have_content('Profundiza en tus Momentos - eventos y ' \
                                 'situaciones que afectan tu salud mental')
  end
end
