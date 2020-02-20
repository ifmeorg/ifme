# frozen_string_literal: true

describe AlliesController do
  let(:user) { create(:user) }
  let(:ally) { create(:user, name: 'Marco') }
  let(:notification) { double(:notification) }

  describe '#index' do
    subject { get :index }

    context 'when user is logged in' do
      include_context :logged_in_user

      it 'renders the correct template' do
        expect(subject).to render_template(:index)
      end

      it 'sets the correct instance variables' do
        incoming_ally = create(:user, name: 'Stella')
        outgoing_ally = create(:user, name: 'Sam')
        invited_ally = create(:user, invited_by: user)

        allow(user).to receive(:allies_by_status).with(:accepted).and_return([ally])
        allow(user).to receive(:allies_by_status).with(:pending_from_user).and_return([incoming_ally])
        allow(user).to receive(:allies_by_status).with(:pending_from_ally).and_return([outgoing_ally])

        subject
        expect(assigns(:page_search)).to eq true
        expect(assigns(:accepted_allies)).to eq [ally]
        expect(assigns(:incoming_ally_requests)).to eq [incoming_ally]
        expect(assigns(:outgoing_ally_requests)).to eq [outgoing_ally]
        expect(assigns(:invited_allies)).to eq [invited_ally]
      end
    end

    context 'when user is not logged in' do
      before { subject }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #add' do
    context 'when user is logged in' do
      include_context :logged_in_user

      let(:notification_params) do
        {
          user_id: ally.id.to_s,
          uniqueid: "#{notification_type}_#{user.id}",
          data: {
            user: user.name,
            user_id: user.id,
            uid: user.uid,
            type: notification_type,
            uniqueid: "#{notification_type}_#{user.id}"
          }.to_json
        }
      end

      subject { post :add, params: { ally_id: ally.id } }

      context 'with an existing ally request' do
        let!(:allyship) do
          Allyship.create(
            user_id: user.id,
            ally_id: ally.id,
            status: :pending_from_ally
          )
        end

        let!(:notification) do
          create(:notification, uniqueid: "new_ally_request_#{ally.id}", user_id: user.id)
        end

        let!(:notification_type) { 'accepted_ally_request' }

        it 'updates the allyship status to "accepted"' do
          subject
          expect(allyship.reload.status).to eq 'accepted'
        end

        it 'deletes the allyship request notification' do
          expect { subject }.to change { user.notifications.count }.from(1).to(0)
        end

        it 'creates an accepted allyship request notification' do
          expect(Notification).to receive(:create).with(notification_params)
          subject
        end

        it 'sends an email notification to the ally' do
          data = {
            user: user.name,
            user_id: user.id,
            uid: user.uid,
            type: notification_type.to_s,
            uniqueid: "#{notification_type}_#{user.id}"
          }.to_json
          allow(NotificationMailer).to receive(:notification_email).with(ally.id.to_s, data).and_return(notification)
          expect(notification).to receive(:deliver_now)
          subject
        end
      end

      context 'with no existing allyship request' do
        let(:notification_type) { 'new_ally_request' }

        it 'creates a pending allyship request' do
          expect(Allyship).to receive(:create).with(
            user_id: user.id,
            ally_id: ally.id.to_s,
            status: :pending_from_ally
          )
          subject
          expect(response).to redirect_to allies_path
        end

        it 'creates a new allyship request notification' do
          expect(Notification).to receive(:create).with(notification_params)
          subject
          expect(response).to redirect_to allies_path
        end
      end
    end

    context 'when user is not logged in' do
      before { post :add }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'DELETE #remove' do
    let!(:allyship) { double(:allyship) }

    context 'when user is logged in' do
      include_context :logged_in_user

      it 'deletes the allyship' do
        allow(Allyship).to receive(:where).and_return(allyship)
        expect(allyship).to receive(:destroy_all)
        delete :remove, params: { ally_id: ally.id }
        expect(response).to redirect_to allies_path
      end
    end

    context 'when user is not logged in' do
      before { delete :remove }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
