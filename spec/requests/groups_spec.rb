# frozen_string_literal: true

describe 'Groups', type: :request do
  let(:user) { create(:user1) }

  describe 'GET #index' do
    context 'when user is signed in' do
      before { sign_in user }

      it 'renders page with groups that the user belongs to' do
        group = create :group_with_member, user_id: user.id, name: 'group one'
        other_user = build_stubbed(:user2)
        other_group = create :group_with_member,
                             user_id: other_user.id,
                             name: 'group two'

        get groups_url

        expect(response.body).to include(group.name)
        expect(response.body).not_to include(other_group.name)
      end
    end

    context "when user isn't signed in" do
      it 'redirects to the sign in page' do
        get groups_url

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'when the group exists' do
        let(:group) { create :group, name: 'test group name' }

        it 'renders page with group' do
          get group_path(id: group.id)

          expect(response.body).to include(group.name)
        end

        context 'when user is member of the group' do
          it "renders page with group's meetings" do
            group = create :group_with_member, user_id: user.id
            meeting = create :meeting, group_id: group.id, name: 'test meeting'

            get group_path(id: group.id)

            expect(response.body).to include(meeting.name)
          end
        end
      end

      context "when group doesn't exist" do
        it 'redirects to the index' do
          get group_path(id: 999)

          expect(response).to redirect_to(groups_path)
        end
      end
    end

    context "when user isn't signed in" do
      it 'redirects to sign in' do
        get group_path(id: 999)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    before { sign_in user }

    it 'redirects to groups path when current_user is not a leader' do
      group = create :group

      get edit_group_path(id: group.id)

      expect(response).to redirect_to(groups_path)
    end
  end

  describe 'PUT #update' do
    before { sign_in user }

    it 'updates leader' do
      group = create :group
      user = create :user
      non_leader = create :group_member, group: group, leader: false, user: user

      put group_path(group), params: { group: { leader: [user.id] } }

      non_leader.reload
      expect(non_leader.leader).to be true
    end

    it 'returns error response if there is an empty name or description' do
      group = create :group
      params = { group: { name: nil, description: nil }, format: 'json' }

      put group_path(group), params: params

      group.reload
      json = JSON.parse(response.body)

      expect(response.code).to eq('422')
      expect(json['name']).to eq(["can't be blank"])
      expect(json['description']).to eq(["can't be blank"])
    end
  end

  describe 'POST #create' do
    before { sign_in user }

    it 'creates a new group and assigns the leader' do
      test_name = 'Test Name'
      test_description = 'This is a test description.'
      params = { group: { name: test_name, description: test_description } }

      post groups_path, params: params

      expect(response.code).to eq('302')

      created_group = Group.last
      expect(created_group.name).to eq(test_name)
      expect(created_group.description).to eq(test_description)

      member = created_group.group_members.first
      expect(member.user_id).to eq(user.id)
      expect(member.leader).to eq(true)
    end

    it 'returns error response if params are missing' do
      params = { group: { name: nil, description: nil }, format: 'json' }

      post groups_path, params: params

      json = JSON.parse(response.body)

      expect(response.code).to eq('422')
      expect(json['name']).to eq(["can't be blank"])
      expect(json['description']).to eq(["can't be blank"])
    end
  end

  describe 'DELETE #destroy' do
    before { sign_in user }

    it 'deletes the group' do
      group = create :group

      delete group_path(group)

      expect(response.code).to eq('302')
      expect(Group.find_by(id: group.id)).to be_nil
    end
  end
end
