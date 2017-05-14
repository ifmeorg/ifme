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
  end
end
