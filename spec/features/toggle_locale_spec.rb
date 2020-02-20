# frozen_string_literal: true

describe 'ToggleLocale', js: true do
  let(:user) { create :user }

  feature 'Toggling the locale dropdown to change the language' do
    let(:en_root_title) do
      'A community for mental health experiences'
    end
    let(:es_root_title) do
      'Una comunidad para compartir experiencias de salud mental'
    end

    let(:en_signed_in_root_title) { "Hello #{user.name}!" }
    let(:es_signed_in_root_title) { "¡Hola #{user.name}!" }

    context 'When on pages that do not require sign in' do
      before { visit(root_path) }

      it 'toggles locale dropdown on the same page' do
        expect(page).to have_content en_root_title
        change_language('es')
        expect(page).to have_content es_root_title
        change_language('en')
        expect(page).to have_content en_root_title
      end

      it 'persists locale selection on a different page' do
        change_language('es')
        expect(page).to have_content es_root_title
        scroll_to('.footer')

        change_page(
          lambda {
            within '.footer' do
              click_link('Acerca de')
            end
          },
          '.pageTitle',
          have_content('Acerca de')
        )

        change_language('en')
        expect(find('.pageTitle')).to have_content 'About'
      end
    end

    context 'When signed out and then signed in' do
      before do
        visit(root_path)
        change_language('en')
      end

      it 'persists locale selection from signed out to signed in state', header: true do
        expect(page).to have_content en_root_title

        change_language('es')
        expect(page).to have_content(es_root_title)

        open_header_if_hidden

        change_page(
          lambda {
            within '#header' do
              click_link('Ingresar')
            end
          },
          '.pageTitle',
          have_content('Comparte tus historias ahora')
        )

        within '#new_user' do
          fill_in('user_email', with: user.email)
          fill_in('user_password', with: user.password)
          click_button('Ingresar')
        end

        expect(find('.pageTitle')).to have_content es_signed_in_root_title

        sleep(5)

        change_page(
          lambda {
            within '.dashboardSection' do
              click_link('Momentos')
            end
          },
          '.pageTitle',
          have_content('Momentos')
        )
      end
    end

    context 'When signed in and then signed out' do
      before do
        login_as(user)
        visit(root_path)
        change_language('en')
      end

      it 'persists locale selection from signed in to signed out state' do
        change_language('es')
        expect(find('.pageTitle')).to have_content es_signed_in_root_title
        logout(:user)
        expect(find('.pageTitle')).to have_content es_signed_in_root_title
      end
    end

    context 'When signed in' do
      before do
        login_as(user)
        visit(root_path)
        change_language('en')
      end

      it 'toggles locale selection on the same page' do
        expect(find('.pageTitle')).to have_content en_signed_in_root_title
        change_language('es')
        expect(find('.pageTitle')).to have_content es_signed_in_root_title
        change_language('en')
        expect(find('.pageTitle')).to have_content en_signed_in_root_title
      end

      it 'persists locale selection on a different page', feature: true do
        expect(find('.pageTitle')).to have_content en_signed_in_root_title
        change_language('es')
        expect(find('.pageTitle')).to have_content es_signed_in_root_title

        change_page(
          lambda {
            within '.dashboardSection' do
              click_link('Estrategias')
            end
          },
          '.pageTitle',
          have_content('Estrategias')
        )
      end
    end
  end
end
