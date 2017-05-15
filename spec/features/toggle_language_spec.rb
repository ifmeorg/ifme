describe 'ToggleLanguage', js: true do
  let(:user) { create :user1 }

  feature 'Toggling the locale dropdown to change the language' do
    describe 'When not signed in' do
      before(:each) do
        logout(:user)
        visit root_path
      end

      it 'language can be toggled on the same page' do
        within '#page_title' do
          expect(page).to have_content 'if me is a community for mental health experiences'
        end

        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me is a community for mental health experiences'
        end
      end

      it 'language can be toggled on different pages' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        click_link('Acerca de')
        within '#page_title' do
          expect(page).to have_content 'Acerca de'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'About'
        end
      end
    end

    describe 'when not signed in and then signed in' do
      it 'language toggled when not signed in persists when signed in' do end
    end

    describe 'when signed in and then not signed in' do
      before(:each) do
        login_as user
        visit root_path
      end

      it 'language toggled when signed in persists when not signed in' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        within '.large-screen' do
          click_link('Momentos')
        end

        within '#page_title' do
          expect(page).to have_content 'Momentos'
        end

        within '.large-screen' do
          click_link('Estrategias')
        end

        within '#page_title' do
          expect(page).to have_content 'Estrategias'
        end

        within '.large-screen' do
          click_link('title_expand')
        end

        within '#expand_me' do
          click_link('Cerrar sesión')
        end

        within '#page_title' do
          expect(page).to have_content 'if me es una comunidad para compartir experiencias de salud mental'
        end

        click_link('Contribuidores')
        within '#page_title' do
          expect(page).to have_content 'Contribuidores'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'Contributors'
        end

        click_link('Privacy Policy')
        within '#page_title' do
          expect(page).to have_content 'Privacy Policy'
        end
      end
    end

    describe 'When signed in' do
      before(:each) do
        login_as user
        visit root_path
      end

      it 'language can be toggled on the same page' do
        within '#page_title' do
          expect(page).to have_content 'Welcome'
        end

        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'Welcome'
        end
      end

      it 'language can be toggle on different pages' do
        select 'Español', from: 'locale'
        within '#page_title' do
          expect(page).to have_content '¡Adelante!'
        end

        within '.large-screen' do
          click_link('Momentos')
        end

        within '#page_title' do
          expect(page).to have_content 'Momentos'
        end

        within '.large-screen' do
          click_link('Estrategias')
        end

        within '#page_title' do
          expect(page).to have_content 'Estrategias'
        end

        select 'English', from: 'locale'
        within '#page_title' do
          expect(page).to have_content 'Strategies'
        end

        within '.large-screen' do
          click_link('Medications')
        end

        within '#page_title' do
          expect(page).to have_content 'Medications'
        end
      end
    end
  end
end
