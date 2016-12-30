module Comments
  describe MeetingService do
    context 'is a comment service' do
      subject { described_class.new }

      it { expect(subject).to be_a(BaseService) }
    end

    describe '#delete' do
      let(:user) { create(:user1) }
      let!(:member) { create(:meeting_member, userid: user.id) }
      let!(:comment) do
        create(:comment, id: 1, comment_by: user.id, commented_on: member.meeting.id, visibility: 'all')
      end

      subject { described_class.new(comment: comment, user: user) }

      context 'when the comment exists' do
        context 'and comment belongs to the current_user' do
          it 'destroys the comment' do
            expect do
              subject.delete
            end.to change(Comment, :count).by(-1)
          end
        end

        xcontext 'and the meeting belongs to the current_user' do
          let!(:member) { create(:meeting_member, userid: 1) }

          it 'destroys the comment' do
            expect do
              subject.delete
            end.to change(Comment, :count).by(-1)
          end
        end
      end
    end

    describe 'create' do
    end
  end
end
