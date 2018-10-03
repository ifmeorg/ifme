describe ReminderHelper do
  name1 = 'name1'
  name2 = 'name2'
  reminder_names = [
    name1, name2
  ]

  describe '#has_reminders?' do
    it 'returns false when data has no active_reminder method' do
      expect(has_reminders?({})).to be_falsey
    end

    it 'returns false when data has no active reminder' do
      user = FactoryBot.create(:user)      
      medication = FactoryBot.create(:medication, user_id: user.id)      
      expect(has_reminders?(medication)).to be_falsey
    end

    it 'returns true when data is good' do
      user = FactoryBot.create(:user)
      medication = FactoryBot.create(:medication, :with_daily_reminder, user_id: user.id)      
      expect(has_reminders?(medication)).to be_truthy
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
      expected_html = '<div><i class="fa fa-bell smallerMarginRight"></i>name1, name2</div>'
      expect(reminders).to eq(expected_html)
    end
  end

  describe '#print_reminders' do
    it 'returns empty string when data has no reminders' do
      reminders = print_reminders({})
      expect(reminders).to eq('')
    end
  
    it 'returns correct html when data has reminders' do
      user = FactoryBot.create(:user)
      medication = FactoryBot.create(:medication, :with_daily_reminder, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = '<div><i class="fa fa-bell smallerMarginRight"></i>' + I18n.t('common.daily_reminder') + '</div>'
      expect(reminders).to eq(expected_html)
    end
  end

end
