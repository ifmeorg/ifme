describe ReportsController, type: :controller do
  describe '#create' do
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

    context 'does not have comment_id' do
      let(:comment_id) { nil }

      context 'reporter and reportee are not allies' do
        it 'cannot create a report' do
          sign_in user1
          post :create, params: report_params
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
          expect(flash[:alert]).to eq("Could not send report for #{user2.name}")
        end
      end

      context 'reporter and reportee are allies' do
        before do
          create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
        end

        it 'creates a report' do
          sign_in user1
          post :create, params: report_params
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
          expect(flash[:notice]).to eq("Report for #{user2.name} sent")
        end
      end
    end

    context 'has a valid comment_id' do
      let(:moment) { create(:moment, user_id: user1.id) }
      let(:comment) { create(:comment, commentable_id: moment.id, comment_by: user2.id, visibility: 'all') }
      let(:comment_id) { comment.id }

      context 'reporter and reportee are not allies' do
        it 'cannot create a report' do
          sign_in user1
          post :create, params: report_params
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
          expect(flash[:alert]).to eq("Could not send report for #{user2.name}")
        end
      end

      context 'reporter and reportee are allies' do
        before do
          create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
        end

        it 'creates a report' do
          sign_in user1
          post :create, params: report_params
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
          expect(flash[:notice]).to eq("Report for #{user2.name} sent")
        end
      end
    end

    context 'has an invalid comment_id' do
      let(:comment_id) { -1 }

      context 'reporter and reportee are not allies' do
        it 'cannot create a report' do
          sign_in user1
          post :create, params: report_params
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
          expect(flash[:alert]).to eq("Could not send report for #{user2.name}")
        end
      end

      context 'reporter and reportee are allies' do
        before do
          create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
        end

        it 'creates a report' do
          sign_in user1
          post :create, params: report_params
          expect(response).to redirect_to(new_report_path(uid: user2.uid))
          expect(flash[:alert]).to eq("Could not send report for #{user2.name}")
        end
      end
    end
  end
end
