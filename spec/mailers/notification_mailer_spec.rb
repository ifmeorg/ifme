# frozen_string_literal: true
describe 'NotificationMailer' do
  let(:recipient)  { create(:user1, email: 'some@user.com') }
  let(:medication) { create(:medication, :with_daily_reminder, user_id: recipient.id) }
  let(:medication_reminder) { medication.take_medication_reminder }
  let(:strategy) { create(:strategy, :with_daily_reminder, user_id: recipient.id) }
  let(:group) { create(:group) }
  let(:strategy_reminder) { strategy.perform_strategy_reminder }
  let(:meeting) { create(:meeting) }

  describe '#take_medication' do
    subject(:email) { NotificationMailer.take_medication(medication_reminder) }

    it { expect(email.to).to eq(['some@user.com']) }
    it { expect(email.subject).to eq("Don't forget to take #{medication.name}!") }
  end

  describe '#refill_medication' do
    subject(:email) { NotificationMailer.refill_medication(medication_reminder) }

    it { expect(email.to).to eq(['some@user.com']) }
    it { expect(email.subject).to eq("Your refill for #{medication.name} is coming up soon!") }
  end

  describe '#perform_strategy' do
    subject(:email) { NotificationMailer.perform_strategy(strategy_reminder) }

    it { expect(email.to).to eq(['some@user.com']) }
    it { expect(email.subject).to eq("Don't forget to perform Test Strategy!") }
  end

  describe '#meeting_reminder' do
    let(:member) { create(:meeting_member, meeting: meeting).user }

    subject(:email) { NotificationMailer.meeting_reminder(meeting, member) }

    it 'sends the email to the correct recipient' do
      expect(email.to).to eq([member.email])
    end

    it 'has the correct subject' do
      expected_subject = I18n.t(
        'meetings.reminder_mailer.subject',
        meeting_name: meeting.name,
        time: meeting.time
      )

      expect(email.subject).to eq(expected_subject)
    end

    it 'is addressed to the correct person' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(member.name)
      end
    end

    it 'includes the meeting location' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(meeting.location)
      end
    end

    it 'includes the meeting time' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(meeting.time)
      end
    end

    it 'includes the meeting name' do
      email.parts.each do |part|
        expect(part.body.raw_source).to include(meeting.name)
      end
    end
  end

  describe 'notification' do
    let(:group_link) { "<a href=\"http://localhost:3000/groups/#{group.id}\">click here</a>" }
    let(:meeting_link) { "<a href=\"http://localhost:3000/meetings/#{meeting.id}\">click here</a>" }
    let(:code_of_conduct_link) { '<a href="https://www.contributor-covenant.org/">Code of Conduct</a>' }
    let(:who_triggered_event) { create(:user2) }
    let(:data) do
      {
        user: who_triggered_event.name,
        user_id: who_triggered_event.id,
        uid: who_triggered_event.uid,
        type: type,
        uniqueid: 'some_unique_id',
        group_id: group.id,
        group: group.name
      }.to_json
    end

    context 'when type is accepted_ally_request' do
      let(:type) { 'accepted_ally_request' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} accepted your ally request!") }
      it { expect(email.body.encoded).to match("<p>Congrats! You can now share Moments, Strategies, and more with #{who_triggered_event.name}.</p>") }
    end

    context 'when type is new_ally_request' do
      let(:type) { 'new_ally_request' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} sent an ally request!") }
      it { expect(email.body.encoded).to match('<p>Please <a href="http://localhost:3000/allies">sign in</a> to accept or reject the request!</p>') }
    end

    context 'when type is new_group' do
      let(:type) { 'new_group' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} created a group \"#{group.name}\"") }
      it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
      it { expect(email.body.encoded).to match("<p>#{who_triggered_event.name} created a group \"#{group.name}\":</p><p><i>#{group.description}</i></p><p>To learn more and join, #{group_link}!</p><p>Please follow our #{code_of_conduct_link}!</p>") }
    end

    context 'when type is new_group_member' do
      let(:type) { 'new_group_member' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} joined your group \"#{group.name}\"") }
      it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
      it { expect(email.body.encoded).to match("<p>To see \"#{group.name}\", #{group_link}!</p>") }
    end

    context 'when type is add_group_leader' do
      let(:type) { 'add_group_leader' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} became a leader of \" #{group.name}\"") }
      it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
      it { expect(email.body.encoded).to match("<p>To see \"#{group.name}\", #{group_link}!</p>") }
    end

    context 'when type is add_group_leader and sender is recipient' do
      let(:type) { 'add_group_leader' }

      subject(:email) { NotificationMailer.notification_email(who_triggered_event, data) }

      it { expect(email.subject).to eq("if me | You became a leader of \"#{group.name}\"") }
      it { expect(email.body.encoded).to match("Hi #{who_triggered_event.name},") }
      it { expect(email.body.encoded).to match("<p>To see \"#{group.name}\", #{group_link}!</p>") }
    end

    context 'when type is remove_group_leader' do
      let(:type) { 'remove_group_leader' }

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} is no longer a leader of \"#{group.name}\"") }
      it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
      it { expect(email.body.encoded).to match("<p>To see \"#{group.name}\", #{group_link}!</p>") }
    end

    context 'when type is remove_group_leader and sender is recipient' do
      let(:type) { 'remove_group_leader' }

      subject(:email) { NotificationMailer.notification_email(who_triggered_event, data) }

      it { expect(email.subject).to eq("if me | You are no longer a leader of \"#{group.name}\"") }
      it { expect(email.body.encoded).to match("Hi #{who_triggered_event.name},") }
      it { expect(email.body.encoded).to match("<p>To see \"#{group.name}\", #{group_link}!</p>") }
    end

    describe 'when meeting notification' do
      let(:data) do
        {
          user: who_triggered_event.name,
          typeid: meeting.id,
          typename: meeting.name,
          cutoff: false,
          type: type,
          uniqueid: 'some_unique_id',
          group: group.name,
          group_id: group.id
        }.to_json
      end

      context 'when type is new_meeting' do
        let(:new_meeting_subject) { "if me | #{who_triggered_event.name} has created a new meeting \"#{meeting.name}\" for \"#{group.name}\"" }
        let(:type) { 'new_meeting' }

        subject(:email) { NotificationMailer.notification_email(recipient, data) }

        it { expect(email.subject).to eq(new_meeting_subject.to_s) }
        it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
        it do
          expect(email.body.encoded).to match([
            "<p>#{new_meeting_subject}</p><p><i>#{meeting.description}</i></p>",
            "<p><strong>Location:</strong> #{meeting.location}</p>",
            "<p><strong>Date:</strong> #{meeting.date}</p><p><strong>Time:</strong> #{meeting.time}</p>",
            "<p>To learn more and attend, <a href=\"http://localhost:3000/groups/#{group.id}\">click here</a>!</p>"
          ].join("\n"))
        end
      end

      context 'when type is update_meeting' do
        let(:update_meeting_subject) { "if me | #{who_triggered_event.name} has updated the meeting \"#{meeting.name}\" for \"#{group.name}\"" }
        let(:type) { 'update_meeting' }

        subject(:email) { NotificationMailer.notification_email(recipient, data) }

        it { expect(email.subject).to eq(update_meeting_subject.to_s) }
        it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
        it do
          expect(email.body.encoded).to match([
            "<p>#{update_meeting_subject}</p><p><i>#{meeting.description}</i></p>",
            "<p><strong>Location:</strong> #{meeting.location}</p>",
            "<p><strong>Date:</strong> #{meeting.date}</p><p><strong>Time:</strong> #{meeting.time}</p>",
            "<p>To learn more, <a href=\"http://localhost:3000/groups/#{group.id}\">click here</a>!</p>"
          ].join("\n"))
        end
      end

      context 'when type is remove_meeting' do
        let(:remove_meeting_subject) { "if me | #{who_triggered_event.name} has cancelled \"#{meeting.name}\" for \"#{group.name}\"" }
        let(:type) { 'remove_meeting' }

        subject(:email) { NotificationMailer.notification_email(recipient, data) }

        it { expect(email.subject).to eq(remove_meeting_subject.to_s) }
        it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
        it { expect(email.body.encoded).to match("<p>To see \"#{group.name}\", #{group_link}!</p>") }
      end

      context 'when type is join_meeting' do
        let(:join_meeting_subject) { "if me | #{who_triggered_event.name} has joined \"#{meeting.name}\" for \"#{group.name}\"" }
        let(:type) { 'join_meeting' }

        subject(:email) { NotificationMailer.notification_email(recipient, data) }

        it { expect(email.subject).to eq(join_meeting_subject.to_s) }
        it { expect(email.body.encoded).to match("Hi #{recipient.name},") }
        it { expect(email.body.encoded).to match("<p>To see \"#{meeting.name}\", #{meeting_link}!</p>") }
      end
    end

    describe 'when type is comment on moment' do
      let(:moment_desc) { 'some_moment_description' }
      let(:phrase_ally) { "<p>Your ally <strong>#{who_triggered_event.name}" }
      let(:comment)     { '</strong> commented:</p><p><i>my_comment</i></p>' }
      let(:link) do
        '<p>To read it, <a href="http://localhost:3000/moments/1">click here</a>!</p>'
      end

      let(:data) do
        {
          user: who_triggered_event.name,
          typeid: 1,
          typename: moment_desc,
          commentid: 2,
          comment: 'my_comment',
          cutoff: false,
          type: 'comment_on_moment',
          uniqueid: 'some_unique_id'
        }.to_json
      end

      subject(:email) { NotificationMailer.notification_email(recipient, data) }

      it { expect(email.subject).to eq("if me | #{who_triggered_event.name} commented on your moment \"#{moment_desc}\"") }
      it { expect(email.body.encoded).to match(phrase_ally) }
      it { expect(email.body.encoded).to match(comment) }
      it { expect(email.body.encoded).to match(link) }
    end
  end
end
