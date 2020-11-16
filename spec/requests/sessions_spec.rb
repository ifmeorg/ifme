# frozen_string_literal: true

describe 'Sessions', type: :request do
  let(:recaptcha_id) { 'recaptcha-form' }

  describe '#new' do
    after { cookies[:login_recaptcha] = nil }

    context 'when user has recaptcha cookie' do
      it 'displays recaptcha' do
        cookies[:login_recaptcha] = true
        get new_user_session_path

        expect(response.body).to include recaptcha_id
      end
    end

    context 'when user does not have recaptcha cookie' do
      context 'and recaptcha is specified in query string' do
        before do
          get new_user_session_path, params: { recaptcha: true }
        end

        it 'displays recaptcha' do
          expect(response.body).to include recaptcha_id
        end

        it 'sets recaptcha cookie' do
          expect(cookies[:login_recaptcha]).to eq 'true'
        end
      end

      context 'and recaptcha is not specified in query string' do
        context 'and sign in params are not present' do
          it 'does not display recaptcha' do
            get new_user_session_path

            expect(response.body).to_not include recaptcha_id
          end
        end

        context 'and user is specified in sign in params' do
          context 'and user has less than 3 failed logins' do
            let(:user) { create(:user, failed_attempts: 0) }

            it 'does not display recaptcha' do
              get new_user_session_path, params: { email: user.email }

              expect(response.body).to_not include recaptcha_id
            end
          end

          context 'and user has 3 failed logins' do
            let(:user) { create(:user, failed_attempts: 3) }

            before do
              get new_user_session_path, params: { user: { email: user.email } }
            end

            it 'displays recaptcha' do
              expect(response.body).to include recaptcha_id
            end

            it 'sets recaptcha cookie' do
              expect(cookies[:login_recaptcha]).to eq 'true'
            end
          end
        end
      end
    end
  end

  describe '#post' do
    let(:password) { 'password' }
    let(:user) { create(:user, failed_attempts: 5, password: password) }

    context 'when user does not require recaptcha' do
      it 'does not check recaptcha' do
        expect(SessionsController).to_not receive(:verify_recaptcha)

        post "/users/sign_in", params: { user: { email: user.email, password: password } }
      end
    end

    context 'when user requires recaptcha' do
      before { cookies[:login_recaptcha] = 'true' }
      after { cookies[:login_recaptcha] = nil }

      context 'and recaptcha is not filled out' do
        before do
          allow_any_instance_of(SessionsController).to receive(:verify_recaptcha).and_return(false)
        end

        it 'redirects to sign in page with recaptcha flag' do
          post "/users/sign_in", params: { user: { email: user.email, password: password } }

          expect(response).to redirect_to new_user_session_path(recaptcha: true)
        end
      end

      context 'and recaptcha is filled out' do
        let(:entered_password) { password }

        before do
          allow_any_instance_of(SessionsController).to receive(:verify_recaptcha).and_return(true)
          post "/users/sign_in", params: { user: { email: user.email, password: entered_password } }
        end

        it 'clears recaptcha cookie' do
          expect(cookies[:login_recaptcha]).to eq ''
        end

        context 'and credentials are valid' do
          it 'signs user in' do
            expect(response).to redirect_to '/'
          end
        end

        context 'and credentials are invalid' do
          let(:entered_password) { 'invalid_password' }

          it 'redirects to sign in page with recaptcha' do
            expect(response.body).to include recaptcha_id
          end
        end
      end
    end
  end
end
