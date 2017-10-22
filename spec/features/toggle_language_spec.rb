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
        expect(find('#page_title')).to have_content en_root_title
        change_language('es')
        expect(find('#page_title')).to have_content es_root_title
        change_language('en')
        expect(find('#page_title')).to have_content en_root_title
      end

      it 'persists locale selection on a different page' do
        change_language('es')
        expect(find('#page_title')).to have_content es_root_title

        within '#footer' do
          click_link('Acerca de')
        end

        expect(find('#page_title')).to have_content 'Acerca de'
        change_language('en')
        expect(find('#page_title')).to have_content 'About'
      end
    end

    context 'When signed out and then signed in' do
      before do
        visit(root_path)
        change_language('en')
      end

      it 'persists locale selection from signed out to signed in state' do
        expect(page).to have_content en_root_title

        change_language('es')
        expect(find('#page_title')).to have_content es_root_title

        within '#header_content' do
          click_link('Ingresar')
        end

        within '#new_user' do
          fill_in('user_email', with: user.email)
          fill_in('user_password', with: user.password)
          click_button('Ingresar')
        end

        expect(find('#page_title')).to have_content es_signed_in_root_title

        within '.large-screen' do
          click_link('Momentos')
        end

        expect(find('#page_title')).to have_content 'Momentos'
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
        expect(find('#page_title')).to have_content es_signed_in_root_title
        logout(:user)
        expect(find('#page_title')).to have_content es_signed_in_root_title
      end
    end

    context 'When signed in' do
      before do
        login_as(user)
        visit(root_path)
        change_language('en')
      end

      it 'toggles locale selection on the same page' do
        expect(find('#page_title')).to have_content en_signed_in_root_title
        change_language('es')
        expect(find('#page_title')).to have_content es_signed_in_root_title
        change_language('en')
        expect(find('#page_title')).to have_content en_signed_in_root_title
      end

      it 'persists locale selection on a different page' do
        expect(find('#page_title')).to have_content en_signed_in_root_title
        change_language('es')
        expect(find('#page_title')).to have_content es_signed_in_root_title

        within '.large-screen' do
          click_link('Estrategias')
        end

        expect(find('#page_title')).to have_content 'Estrategias'
      end
    end
  end
end
