# frozen_string_literal: true

describe GroupsHelper do
  let(:user) { create :user }
  let!(:another_user) { create :user }
  let!(:group_leader) { create :group_member, user_id: user.id, leader: true }
  let!(:group_with_member) { group_leader.group }
  let!(:group_without_member) { create :group }
  let!(:meeting_leader) { create :meeting_member, user_id: user.id, leader: true }
  let!(:meeting) { meeting_leader.meeting }
  let!(:another_meeting) { create :meeting }

  before { allow_to_receive(:current_user, user) }

  describe '#user_can_edit?' do
    subject { user_can_edit?(object) }

    context 'when user is not a member' do
      let(:object) { group_without_member }

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'when user is a member' do
      let(:object) { group_with_member }

      it 'returns true' do
        expect(subject).to eq true
      end
    end
  end

  describe '#user_can_leave?' do
    subject { user_can_leave?(object) }

    context 'when user is not a leader' do
      let(:object) { group_without_member }

      before { allow_to_receive(:user_is_leader_of?, false) }

      it 'returns true' do
        expect(subject).to eq true
      end
    end

    context 'when user is a leader' do
      let(:object) { group_with_member }

      it 'returns false' do
        expect(subject).to eq false
      end
    end
  end

  describe '#user_can_delete?' do
    subject { user_can_delete?(object) }

    context 'when user is not a leader' do
      let(:object) { group_without_member }

      it 'returns false' do
        expect(subject).to eq false
      end
    end

    context 'when user is a leader' do
      let(:object) { group_with_member }

      it 'returns true' do
        expect(subject).to eq true
      end
    end
  end

  describe '#edit_group_link' do
    subject { edit_group_link(object) }

    let(:object) { group_with_member }

    it 'returns link for editing' do
      expect(subject).to eq("<a class=\"smallMarginRight\" href=\"/groups/#{to_route_style(object.name)}/edit\">Edit</a>")
    end
  end

  describe '#leader_link' do
    subject { leader_link(object) }

    context 'when leader is current user' do
      let(:object) { user }

      it 'returns link with \'You\' text' do
        expect(subject).to eq("<a href=\"/profile?uid=#{object.uid}\">You</a>")
      end
    end

    context 'when leader is not a current user' do
      let(:object) { another_user }

      it 'returns link with name of the user text' do
        expect(subject).to eq("<a href=\"/profile?uid=#{object.uid}\">#{object.name}</a>")
      end
    end
  end

  describe '#delete_group_link' do
    subject { delete_group_link(object) }

    context do
      let(:object) { group_with_member }

      it 'returns link for deleting the group' do
        expect(subject).to eq("<a data-confirm=\"Are you sure?\" rel=\"nofollow\" data-method=\"delete\" href=\"/groups/#{to_route_style(object.name)}\">Delete</a>")
      end
    end
  end

  describe '#kick_member_link' do
    subject { kick_member_link(object1, object2) }

    context do
      let(:object1) { group_with_member }
      let(:object2) { user }

      it 'returns link for kicking member from the group' do
        expect(subject).to eq("<a class=\"kick\" rel=\"nofollow\" data-method=\"delete\" href=\"/groups/#{object1.id}/membership/#{object2.id}\">Remove</a>")
      end
    end
  end

  describe '#leave_group_link' do
    subject { leave_group_link(object) }

    context do
      let(:object) { group_with_member }

      it 'returns link for leaving the group' do
        expect(subject).to eq("<a id=\"leave\" rel=\"nofollow\" data-method=\"delete\" href=\"/groups/#{object.id}/membership\">Leave</a>")
      end
    end
  end

  describe '#join_group_link' do
    subject { join_group_link(object) }

    context do
      let(:object) { group_with_member }

      it 'returns link for joining the group' do
        expect(subject).to eq("<a id=\"join\" rel=\"nofollow\" data-method=\"post\" href=\"/groups/#{object.id}/membership\">Join</a>")
      end
    end
  end

  describe '#edit_meeting_link' do
    subject { edit_meeting_link(object) }

    context 'when current_user is the leader of the meeting' do
      let(:object) { meeting }

      it 'returns link for editing the meeting' do
        expect(subject).to eq("<a href=\"/meetings/#{to_route_style(object.name)}/edit\"><i class=\"fa fa-pencil-alt\"></i></a>")
      end
    end

    context 'when current_user is not the leader of the meeting' do
      let(:object) { another_meeting }

      it 'returns link for editing the meeting' do
        expect(subject).to eq nil
      end
    end
  end

  private

  def allow_to_receive(method, result)
    allow_any_instance_of(GroupsHelper).to receive(method).and_return(result)
  end

  def to_route_style(string)
    string.parameterize.downcase
  end
end
