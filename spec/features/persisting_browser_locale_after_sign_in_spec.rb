RSpec.feature 'Persisting browser locale after sign in', type: :feature do
  scenario 'When user sign in, sign out, then change local', js: true do
    user = create :user

    login_as user
    visit moments_path

    expect(find('.subtitle')).to have_content(
      'Delve deep into your moments - events and situations that affect ' \
      'your mental health.')

    within('#header') { find('a[href="/users/sign_out"]').click }
    expect(find('#header')).to have_content('SIGN IN')

    change_language('es')
    
    login_as user
    visit moments_path

    expect(find('.subtitle')).to have_content(
      'Profundiza en tus Momentos - eventos y situaciones que afectan tu ' \
      'salud mental')
  end
end
