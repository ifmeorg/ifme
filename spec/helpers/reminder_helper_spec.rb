describe ReminderHelper do
  name1 = 'name1'
  name2 = 'name2'
  reminder_names = [
    name1, name2
  ]

  let(:user) {FactoryBot.create(:user)}

  describe '#active_reminders?' do
    it 'returns false when data has no active_reminder method' do
      expect(active_reminders?({})).to be false
    end

    it 'returns false when data has no active reminder' do
      medication = FactoryBot.create(:medication, user_id: user.id)
      expect(active_reminders?(medication)).to be false
    end

    it 'returns true when data is good' do
      medication = FactoryBot.create(:medication, :with_daily_reminder, user_id: user.id)
      expect(active_reminders?(medication)).to be true
    end
  end

  describe '#join_names' do
    it 'correctly joins reminder names with proper connector' do
      reminders = join_names(reminder_names)
      expected_string = 'name1' + I18n.translate('support.array.words_connector') + 'name2'
      expect(reminders).to eq(expected_string)
    end
  end

  describe '#format_reminders' do
    it 'returns correct html div' do
      reminders = format_reminders(reminder_names)
      expected_html = '<div><i class="fa fa-bell smallMarginRight"></i>name1, name2</div>'
      expect(reminders).to eq(expected_html)
    end
  end

  describe '#print_reminders' do
    it 'returns empty string when data has no reminders' do
      reminders = print_reminders({})
      expect(reminders).to eq('')
    end

    it 'returns correct html when data has reminders' do
      medication = FactoryBot.create(:medication, :with_daily_reminder, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = '<div><i class="fa fa-bell smallMarginRight"></i>' + I18n.t('common.daily_reminder') + '</div>'
      expect(reminders).to eq(expected_html)
    end
  end

end
