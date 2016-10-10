RSpec.describe NotificationsController, :type => :controller do

  let(:user) { create(:user) }

  describe 'DELETE #destroy' do
    let(:notification) { build_stubbed(:notification) }
    let(:last_visited_path) { '/' }

    subject { delete :destroy, id: notification.id }

    before { request.env['HTTP_REFERER'] = last_visited_path }

    context 'when a user is singed in' do
      include_context :logged_in_user

      context 'when a notification with the given ID exists' do
        before do
          allow(Notification).to receive(:find).with(notification.id.to_s).and_return(notification)
        end

        context 'when the signed in user is the owner of the notification' do
          before do
            allow(notification).to receive(:user).and_return(user)
          end

          it 'destroys the notification' do
            expect(notification).to receive(:destroy)
            subject
          end

          it 'redirects to the last visited path' do
            allow(notification).to receive(:destroy)
            subject
            expect(response).to redirect_to(last_visited_path)
          end
        end

        context 'when the signed in user is not the owner of the notification' do
          before do
            allow(notification).to receive(:user).and_return(build_stubbed(:user))
          end

          after { subject }

          it 'doesn\'t destroy the notification' do
            expect(notification).not_to receive(:destroy)
          end
        end
      end

      context 'when no notification with the given ID exists' do
        before do
          allow(Notification).to receive(:find).and_raise('NotFoundException')
          subject
        end

        it 'redirects to the last visited path' do
          expect(response).to redirect_to(last_visited_path)
        end
      end
    end

    context 'when no user is signed in' do
      before { subject }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
