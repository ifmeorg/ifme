# frozen_string_literal: true

describe 'Notification', type: :request do
  let(:previous_page) { 'http://example.com/previous' }
  let(:format) { 'text/html' }
  let(:headers) do
    {
      'HTTP_REFERER' => previous_page,
      'ACCEPT' => format
    }
  end

  describe '#destroy' do
    let(:user) { create(:user1) }
    let(:other_user) { create(:user2) }
    let(:notification_owner) { user }
    let!(:notification) { create(:notification, user: notification_owner) }

    context 'when the user is signed in' do
      let(:notification_id) { notification.id }

      before do
        sign_in user

        delete notification_path(id: notification_id), headers: headers
      end

      context 'when notification to be deleted exists' do
        context 'when notification belongs to the user' do
          it 'deletes the notification' do
            expect(Notification.find_by(id: notification_id)).to be_nil
          end

          context 'when requested format is html' do
            let(:format) { 'text/html' }

            it 'redirects the user back to where they were before' do
              expect(response).to redirect_to previous_page
            end
          end

          context 'when requested format is json' do
            let(:format) { 'application/json' }

            it 'renders a HEAD response with :no_content' do
              expect(response).to have_http_status 204
            end
          end
        end

        context 'when notification does not belong to the user' do
          let(:notification_owner) { other_user }

          it 'does not delete the notification' do
            expect(Notification.find_by(id: notification_id)).to_not be_nil
          end

          context 'when requested format is html' do
            let(:format) { 'text/html' }

            it 'redirects the user back to where they were before' do
              expect(response).to redirect_to previous_page
            end
          end

          context 'when requested format is json' do
            let(:format) { 'application/json' }

            it 'renders a HEAD response with :no_content' do
              expect(response).to have_http_status 204
            end
          end
        end
      end

      context 'when notification to be deleted does not exist' do
        let(:notification_id) { 'something-fake' }

        context 'when requested format is html' do
          let(:format) { 'text/html' }

          it 'redirects the user back to where they were before' do
            expect(response).to redirect_to previous_page
          end
        end

        context 'when requested format is json' do
          let(:format) { 'application/json' }

          it 'renders a HEAD response with :no_content' do
            expect(response).to have_http_status 204
          end
        end
      end
    end

    context 'when the user is not signed in' do
      let(:invalid_id) { 'foo' }

      before do
        delete notification_path(id: invalid_id), headers: headers
      end

      context 'when requested format is html' do
        let(:format) { 'text/html' }

        it 'redirects to the new_user_session_path' do
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when requested format is json' do
        let(:format) { 'application/json' }

        it 'renders a HEAD response with :no_content' do
          expect(response).to have_http_status 204
        end
      end
    end
  end

  describe '#clear' do
    let(:user) { FactoryBot.create(:user1) }
    let(:other_user) { FactoryBot.create(:user2) }
    let!(:other_user_notification) { create(:notification, user: other_user) }

    context 'when the user is signed in' do
      before { sign_in user }

      context 'when the user has notifications' do
        let!(:notification) do
          FactoryBot.create(:notification, user: user)
        end

        let!(:notification_two) do
          FactoryBot.create(:notification, user: user)
        end

        it 'deletes all notifications belonging to the current user' do
          expect(Notification.where(user_id: user.id).count).to eq(2)

          delete clear_notifications_url

          expect(Notification.where(user_id: user.id).count).to eq(0)
        end

        it 'does not delete notifications belonging to other users' do
          expect(Notification.where(user_id: other_user.id).count).to eq(1)

          delete clear_notifications_url

          expect(Notification.where(user_id: other_user.id).count).to eq(1)
        end
      end

      context 'when the user does not have notifications' do
        it 'does does not delete any notifications' do
          delete clear_notifications_url

          expect(Notification.where(user_id: user.id)).to be_empty
        end
      end

      it 'renders nothing' do
        delete clear_notifications_url

        expect(response).to have_http_status 200
        expect(response.body).to be_empty
      end
    end

    context 'when the user is not signed in' do
      before do
        delete clear_notifications_url, headers: headers
      end

      context 'when requested format is html' do
        let(:format) { 'text/html' }

        it 'redirects to the new_user_session_path' do
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when requested format is json' do
        let(:format) { 'application/json' }

        it 'renders a HEAD response with :no_content' do
          expect(response).to have_http_status 204
        end
      end
    end
  end

  describe '#fetch_notifications' do
    let(:user) { create(:user1) }
    let(:other_user) { create(:user2) }
    let!(:other_user_notification) { create(:notification, user: other_user) }

    context 'when the user is signed in' do
      let!(:notification) { create(:notification, user: user) }
      let!(:notification_two) { create(:notification, user: user) }
      let(:notification_link) do
        '<a id="MyString" href="/moments/1">Julia Nguyen commented "Hello" on typename</a>'
      end
      let(:expected_result) do
        { fetch_notifications: [notification_link, notification_link] }.to_json
      end

      before do
        sign_in user

        get fetch_notifications_notifications_url
      end

      it 'returns JSON with the users notifications' do
        expect(response.body).to eq expected_result
      end
    end

    context 'when the user is not signed in' do
      before do
        get fetch_notifications_notifications_url, headers: headers
      end

      context 'when requested format is html' do
        let(:format) { 'text/html' }

        it 'redirects to the new_user_session_path' do
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when requested format is json' do
        let(:format) { 'application/json' }

        it 'renders a HEAD response with :no_content' do
          expect(response).to have_http_status 204
        end
      end
    end
  end

  describe '#signed_in' do
    let(:user) { FactoryBot.create(:user1) }

    context 'when the user is signed in' do
      before do
        sign_in user
        get signed_in_notifications_url
      end

      it "returns the user's id" do
        expect(response.body).to eq({ signed_in: user.id }.to_json)
      end
    end

    context 'when the user is not signed in' do
      before do
        get signed_in_notifications_url, headers: headers
      end

      context 'when requested format is html' do
        let(:format) { 'text/html' }

        it 'redirects to the new_user_session_path' do
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when requested format is json' do
        let(:format) { 'application/json' }

        it 'renders a HEAD response with :no_content' do
          expect(response).to have_http_status 204
        end
      end
    end
  end
end
