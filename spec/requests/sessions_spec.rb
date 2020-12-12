# frozen_string_literal: true

describe 'Sessions', type: :request do
  let(:recaptcha_id) { 'recaptcha_form' }

  describe '#new' do
    after { cookies[:login_recaptcha] = nil }

    context 'when recaptcha is not configured' do
      before do
        allow(RecaptchaService).to receive(:recaptcha_configured?).and_return(false)
      end

      it 'does not display recaptcha' do
        cookies[:login_recaptcha] = true
        get new_user_session_path

        expect(response.body).to_not include recaptcha_id
      end
    end 

    context 'when recaptcha is configured' do
      before do
        allow(RecaptchaService).to receive(:recaptcha_configured?).and_return(true)
      end

      context 'when user has recaptcha cookie' do
        it 'displays recaptcha' do
          cookies[:login_recaptcha] = true
          get new_user_session_path

          expect(response.body).to include recaptcha_id
        end
      end

      context 'when recaptcha is specified in query string' do
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

      context 'when user is specified in sign in params' do
        let(:failed_attempts) {}
        let(:user) { create(:user, failed_attempts: failed_attempts) }

        before { get new_user_session_path, params: { user: { email: user.email } } }

        context 'when user does not require recaptcha' do
          let(:failed_attempts) { 0 }

          it 'does not display recaptcha' do
            expect(response.body).to_not include recaptcha_id
          end
        end

        context 'when user requires recaptcha' do
          let(:failed_attempts) { RecaptchaService::MIN_ATTEMPTS_FOR_RECAPTCHA }

          it 'displays recaptcha' do
            expect(response.body).to include recaptcha_id
          end

          it 'sets recaptcha cookie' do
            expect(cookies[:login_recaptcha]).to eq 'true'
          end
        end
      end

      context 'when user does not have recaptcha cookie, recaptcha query param, or sign in params' do
        it 'does not display recaptcha' do
          get new_user_session_path

          expect(response.body).to_not include recaptcha_id
        end
      end
    end
  end

  describe '#post' do
    let(:password) { 'password' }
    let(:failed_attempts) {}
    let(:user) { create(:user, failed_attempts: failed_attempts, password: password) }

    before do
      allow(RecaptchaService).to receive(:recaptcha_configured?).and_return(true)
    end

    context 'when user does not require recaptcha' do
      let(:failed_attempts) { 0 }
      it 'does not check recaptcha' do
        post user_session_path, params: { user: { email: user.email, password: password } }

        expect(response).to redirect_to root_path
      end

      context 'with invalid credentials' do
        it 'remains on sign in page without recaptcha' do
          post user_session_path, params: { user: { email: user.email, password: 'invalid password' } }

          expect(response.status).to eq 200
          expect(response.body).to_not include recaptcha_id
        end
      end
    end

    context 'when user requires recaptcha' do
      let(:failed_attempts) { RecaptchaService::MIN_ATTEMPTS_FOR_RECAPTCHA }

      before { cookies[:login_recaptcha] = 'true' }
      after { cookies[:login_recaptcha] = nil }

      context 'when recaptcha is not filled out' do
        it 'redirects to sign in page with recaptcha flag' do
          allow_any_instance_of(SessionsController).to receive(:verify_recaptcha).and_return(false)
          post user_session_path, params: { user: { email: user.email, password: password } }

          expect(response).to redirect_to new_user_session_path(recaptcha: true)
        end
      end

      context 'when recaptcha is filled out' do
        let(:entered_password) { password }

        before do
          allow_any_instance_of(SessionsController).to receive(:verify_recaptcha).and_return(true)
          post user_session_path, params: { user: { email: user.email, password: entered_password } }
        end

        it 'clears recaptcha cookie' do
          expect(cookies[:login_recaptcha]).to eq ''
        end

        context 'when credentials are valid' do
          it 'signs user in' do
            expect(response).to redirect_to root_path
          end
        end

        context 'when credentials are invalid' do
          let(:entered_password) { 'invalid_password' }

          it 'remains on sign in page with recaptcha' do
            expect(response.status).to eq 200
            expect(response.body).to include recaptcha_id
          end
        end
      end
    end
  end
end
