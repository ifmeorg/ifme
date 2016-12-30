module Comments
  describe MomentService do
    context 'is a comment service' do
      subject { described_class.new }

      it { expect(subject).to be_a(BaseService) }
    end

    describe '#delete' do
      let(:user) { create(:user, id: 1) }
      let!(:comment) do
        create(:comment, id: 1, comment_by: 1, commented_on: 1,
                         visibility: 'all')
      end
      let!(:new_moment) { create(:moment, id: 1, userid: 1) }

      subject { described_class.new(comment: comment, user: user) }

      context 'when the comment exists and belongs to the current_user' do
        it 'destroys the comment' do
          expect do
            subject.delete
          end.to change(Comment, :count).by(-1)
        end
      end

      context 'when the comment exists and the strategy belongs to the current_user' do
        it 'destroys the comment' do
          expect do
            subject.delete
          end.to change(Comment, :count).by(-1)
        end
      end
    end

    describe 'create' do
    end
  end
end
