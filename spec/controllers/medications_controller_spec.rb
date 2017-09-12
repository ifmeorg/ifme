describe MedicationsController do
  describe '#print_reminders' do
    let(:user) { FactoryGirl.create(:user1) }

    subject { controller.print_reminders(medication) }

    describe 'when medication has no reminders' do
      let(:medication) { FactoryGirl.create(:medication, userid: user.id) }

      it 'is empty' do
        expect(subject).to eq('')
      end
    end

    describe 'when medication has refill reminder' do
      let(:medication) { FactoryGirl.create(:medication, :with_refill_reminder, userid: user.id) }

      it 'prints the reminder' do
        expect(subject).to eq('<div class="small_margin_top"><i class="fa fa-bell small_margin_right"></i>Refill reminder email</div>')
      end
    end

    describe 'when medication has daily reminder' do
      let(:medication) { FactoryGirl.create(:medication, :with_daily_reminder, userid: user.id) }

      it 'prints the reminders' do
        expect(subject).to eq('<div class="small_margin_top"><i class="fa fa-bell small_margin_right"></i>Daily reminder email</div>')
      end
    end

    describe 'when medication has both reminders' do
      let(:medication) { FactoryGirl.create(:medication, :with_both_reminders, userid: user.id) }

      it 'prints the reminders' do
        expect(subject).to eq('<div class="small_margin_top"><i class="fa fa-bell small_margin_right"></i>Refill reminder email, Daily reminder email</div>')
      end
    end

    describe 'DELETE #destroy' do
      let(:user) { create(:user) }
      let!(:medication) { create(:medication, user: user) }

      context 'when the user is logged in' do
        include_context :logged_in_user
        it 'deletes the medication' do
          expect { delete :destroy, params: { id: medication.id } }
            .to change(Medication, :count).by(-1)
        end

        it 'redirects to the medications index page' do
          delete :destroy, params: { id: medication.id }
          expect(response).to redirect_to medications_path
        end
      end

      context 'when the user is not logged in' do
        before { delete :destroy, params: { id: medication.id } }
        it_behaves_like :with_no_logged_in_user
      end
    end
  end
end
