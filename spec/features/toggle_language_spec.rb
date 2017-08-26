describe 'ToggleLanguage', js: true do
  let(:user) { create :user }

  feature 'Toggling the locale dropdown to change the language' do
    let(:en_root_title) do
      'if me is a community for mental health experiences'
    end
    let(:es_root_title) do
      'if me es una comunidad para compartir experiencias de salud mental'
    end

    let(:en_signed_in_root_title) { 'Welcome' }
    let(:es_signed_in_root_title) { '¡Adelante!' }

    context 'When on pages that do not require sign in' do
      before { visit(root_path) }

      it 'toggles locale dropdown on the same page' do
        within '#page_title' do
          expect(page).to have_content en_root_title
        end

        select 'Español', from: 'locale'

        within '#page_title' do
          expect(page).to have_content es_root_title
        end

        select 'English', from: 'locale'

        within '#page_title' do
          expect(page).to have_content en_root_title
        end
      end

      it 'persists locale selection on a different page' do
        select 'Español', from: 'locale'

        within '#page_title' do
          expect(page).to have_content es_root_title
        end

        within '#footer' do
          click_link('Acerca de')
        end

        within '#page_title' do
          expect(page).to have_content 'Acerca de'
        end

        select 'English', from: 'locale'

        within '#page_title' do
          expect(page).to have_content 'About'
        end
      end
    end

    context 'When signed out and then signed in' do
      before do
        visit(root_path)
        select 'English', from: 'locale'
      end

      it 'persists locale selection from signed out to signed in state' do
        expect(page).to have_content en_root_title

        select 'Español', from: 'locale'

        within '#page_title' do
          expect(page).to have_content es_root_title
        end

        within '#header_content' do
          click_link('Ingresar')
        end

        within '#new_user' do
          fill_in('user_email', with: user.email)
          fill_in('user_password', with: user.password)
          click_button('Ingresar')
        end

        within '#page_title' do
          expect(page).to have_content es_signed_in_root_title
        end

        within '.large-screen' do
          click_link('Momentos')
        end

        within '#page_title' do
          expect(page).to have_content 'Momentos'
        end
      end
    end

    context 'When signed in and then signed out' do
      before do
        login_as(user)
        visit(root_path)
        select 'English', from: 'locale'
      end

      it 'persists locale selection from signed in to signed out state' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content es_signed_in_root_title
        end

        logout(:user)

        within '#page_title' do
          expect(page).to have_content es_signed_in_root_title
        end
      end
    end

    context 'When signed in' do
      before do
        login_as(user)
        visit(root_path)
        select 'English', from: 'locale'
      end

      it 'toggles locale selection on the same page' do
        within '#page_title' do
          expect(page).to have_content en_signed_in_root_title
        end

        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content es_signed_in_root_title
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content en_signed_in_root_title
        end
      end

      it 'persists locale selection on a different page' do
        within '#page_title' do
          expect(page).to have_content en_signed_in_root_title
        end

        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content es_signed_in_root_title
        end

        within '.large-screen' do
          click_link('Estrategias')
        end

        within '#page_title' do
          expect(page).to have_content 'Estrategias'
        end
      end
    end
  end
end
