# frozen_string_literal: true

describe 'Report', type: :request do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:report_params) do
    {
      uid: user2.uid,
      report: { reasons: 'My reason' },
      reporter_id: user1.id,
      reportee_id: user2.id,
      comment_id: comment_id
    }
  end

  describe '#create' do
    context 'when a user is not signed in' do
      before { post reports_path }
      it_behaves_like :with_no_logged_in_user
    end

    context 'when a user is signed in' do
      subject { post reports_path, params: report_params }

      before { sign_in user1 }

      # Shared examples reduce repeated code
      shared_examples_for 'a report not being created' do
        it 'notifies the user a report cannot be made' do
          expect(flash[:alert]).to eq("Could not send report for #{user2.name}")
        end
        it 'redirects to the new report page' do
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
        end
      end

      shared_examples_for 'a report being created' do
        it 'notifies the user a report was made' do
          expect(flash[:notice]).to eq("Report for #{user2.name} sent")
        end
        it 'redirects to the new report page' do
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
        end
      end

      context 'when a comment_id is not provided' do
        let(:comment_id) { nil }

        context 'when reporter and reportee are not allies' do
          before { subject }

          it_behaves_like 'a report not being created'
        end

        context 'when reporter and reportee are allies' do
          before do
            create(:allyships_accepted, user: user1, ally: user2)
            subject
          end

          it_behaves_like 'a report being created'
        end
      end

      context 'when a valid comment_id is provided' do
        let(:moment) { create(:moment, user: user1) }
        let(:comment) { create(:comment, commentable_id: moment.id, comment_by: user2.id) }
        let(:comment_id) { comment.id }

        context 'when reporter and reportee are not allies' do
          before { subject }

          it_behaves_like 'a report not being created'
        end

        context 'when reporter and reportee are allies' do
          before do
            create(:allyships_accepted, user: user1, ally: user2)
            subject
          end

          it_behaves_like 'a report being created'
        end
      end

      context 'when an invalid comment_id is provided' do
        let(:comment_id) { -1 }

        context 'when reporter and reportee are not allies' do
          before { subject }

          it_behaves_like 'a report not being created'
        end

        context 'when reporter and reportee are allies' do
          before do
            create(:allyships_accepted, user: user1, ally: user2)
            subject
          end

          it_behaves_like 'a report not being created'
        end
      end
    end
  end
end
