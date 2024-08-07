# frozen_string_literal: true

describe NotificationsHelper do
  let(:uniqueid) { 'uniqueid' }

  describe '#comment_link' do
    it 'returns the correct link' do
      data = {
        cutoff: false,
        user: 'Julia Nguyen',
        comment: 'Hello',
        typename: 'typename',
        type: 'type_comment_moment',
        typeid: 1,
        commentable_id: 1
      }
      expect(comment_link(uniqueid, data)).to eq('<a id="uniqueid" href="/moments/1">Julia Nguyen commented "Hello" on typename</a>')
    end

    it 'sanitizes and returns the correct link' do
      data = {
        cutoff: false,
        user: '<IFRAME SRC="javascript:alert(document.domain);"></IFRAME>',
        email: 'julia@example.com',
        comment: 'Hello',
        typename: 'typename',
        type: 'type_comment_moment',
        typeid: 1,
        commentable_id: 1
      }
      expect(comment_link(uniqueid, data)).to eq('<a id="uniqueid" href="/moments/1">julia@example.com commented "Hello" on typename</a>')
    end
  end

  describe '#accepted_ally_link' do
    it 'returns the correct link' do
      data = {
        user: 'Julia Nguyen',
        uid: 'uid'
      }
      expect(accepted_ally_link(uniqueid, data)).to eq('<a id="uniqueid" href="/profile?uid=uid">Julia Nguyen accepted your ally request!</a>')
    end

    it 'sanitizes and returns the correct link' do
      data = {
        user: '<IFRAME SRC="javascript:alert(document.domain);"></IFRAME>',
        email: 'julia@example.com',
        uid: 'uid'
      }
      expect(accepted_ally_link(uniqueid, data)).to eq('<a id="uniqueid" href="/profile?uid=uid">julia@example.com accepted your ally request!</a>')
    end
  end

  describe '#new_ally_request_link' do
    it 'returns the correct link' do
      data = {
        user: 'Julia Nguyen',
        uid: 'uid',
        user_id: 1
      }
      expect(new_ally_request_link(uniqueid, data)).to eq('<div id="uniqueid"><div><a href="/profile?uid=uid">Julia Nguyen</a> sent an ally request!</div><div><a rel="nofollow" data-method="post" href="/allies/add?ally_id=1">Accept</a> | <a data-confirm="Are you sure?" rel="nofollow" data-method="post" href="/allies/remove?ally_id=1">Reject</a></div></div>')
    end

    it 'sanitizes and returns the correct link' do
      data = {
        user: '<IFRAME SRC="javascript:alert(document.domain);"></IFRAME>',
        email: 'julia@example.com',
        uid: 'uid',
        user_id: 1
      }
      expect(new_ally_request_link(uniqueid, data)).to eq('<div id="uniqueid"><div><a href="/profile?uid=uid">julia@example.com</a> sent an ally request!</div><div><a rel="nofollow" data-method="post" href="/allies/add?ally_id=1">Accept</a> | <a data-confirm="Are you sure?" rel="nofollow" data-method="post" href="/allies/remove?ally_id=1">Reject</a></div></div>')
    end
  end

  describe '#group_link' do
    let(:data) do
      {
        type: type,
        user: 'Julia Nguyen',
        group: 'Group name',
        group_id: 1
      }
    end
    let(:dirty_data) do
      {
        type: type,
        user: '<IFRAME SRC="javascript:alert(document.domain);"></IFRAME>',
        email: 'julia@example.com',
        group: 'Group name',
        group_id: 1
      }
    end
    context 'type is new_group' do
      let(:type) { 'new_group' }
      it 'returns the correct link' do
        expect(group_link(uniqueid, data)).to eq('<a id="uniqueid" href="/groups/1">Julia Nguyen created a group "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(group_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/groups/1">julia@example.com created a group "Group name"</a>')
      end
    end

    context 'type is new_group_member' do
      let(:type) { 'new_group_member' }
      it 'returns the correct link' do
        expect(group_link(uniqueid, data)).to eq('<a id="uniqueid" href="/groups/1">Julia Nguyen joined your group "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(group_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/groups/1">julia@example.com joined your group "Group name"</a>')
      end
    end

    context 'type is add_group_leader' do
      let(:type) { 'add_group_leader' }
      it 'returns the correct link' do
        expect(group_link(uniqueid, data)).to eq('<a id="uniqueid" href="/groups/1">Julia Nguyen became a leader of "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(group_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/groups/1">julia@example.com became a leader of "Group name"</a>')
      end
    end

    context 'type is remove_group_leader' do
      let(:type) { 'remove_group_leader' }
      it 'returns the correct link' do
        expect(group_link(uniqueid, data)).to eq('<a id="uniqueid" href="/groups/1">Julia Nguyen is no longer a leader of "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(group_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/groups/1">julia@example.com is no longer a leader of "Group name"</a>')
      end
    end
  end

  describe '#meeting_link' do
    let(:data) do
      {
        type: type,
        user: 'Julia Nguyen',
        group: 'Group name',
        typename: 'Meeting name',
        group_id: 1,
        typeid: 1
      }
    end
    let(:dirty_data) do
      {
        type: type,
        user: '<IFRAME SRC="javascript:alert(document.domain);"></IFRAME>',
        email: 'julia@example.com',
        group: 'Group name',
        typename: 'Meeting name',
        group_id: 1,
        typeid: 1
      }
    end
    context 'type is new_meeting' do
      let(:type) { 'new_meeting' }
      it 'returns the correct link' do
        expect(meeting_link(uniqueid, data)).to eq('<a id="uniqueid" href="/meetings/1">Julia Nguyen created a new meeting "Meeting name" for "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(meeting_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/meetings/1">julia@example.com created a new meeting "Meeting name" for "Group name"</a>')
      end
    end

    context 'type is remove_meeting' do
      let(:type) { 'remove_meeting' }
      it 'returns the correct link' do
        expect(meeting_link(uniqueid, data)).to eq('<a id="uniqueid" href="/groups/1">Julia Nguyen has cancelled "Meeting name" for "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(meeting_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/groups/1">julia@example.com has cancelled "Meeting name" for "Group name"</a>')
      end
    end

    context 'type is update_meeting' do
      let(:type) { 'update_meeting' }
      it 'returns the correct link' do
        expect(meeting_link(uniqueid, data)).to eq('<a id="uniqueid" href="/meetings/1">Julia Nguyen has updated "Meeting name" for "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(meeting_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/meetings/1">julia@example.com has updated "Meeting name" for "Group name"</a>')
      end
    end

    context 'type is join_meeting' do
      let(:type) { 'join_meeting' }
      it 'returns the correct link' do
        expect(meeting_link(uniqueid, data)).to eq('<a id="uniqueid" href="/meetings/1">Julia Nguyen has joined "Meeting name" for "Group name"</a>')
      end

      it 'sanitizes and returns the correct link' do
        expect(meeting_link(uniqueid, dirty_data)).to eq('<a id="uniqueid" href="/meetings/1">julia@example.com has joined "Meeting name" for "Group name"</a>')
      end
    end
  end
end
