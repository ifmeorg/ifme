# frozen_string_literal: true

describe ReminderHelper do
  name1 = 'name1'
  name2 = 'name2'
  reminder_names = [
    name1, name2
  ]

  let(:user) { create(:user_oauth) }

  describe '#active_reminders?' do
    it 'returns false when data has no active_reminder method' do
      expect(active_reminders?({})).to be false
    end

    it 'returns false when data has no active reminder' do
      medication = create(:medication, user_id: user.id)
      expect(active_reminders?(medication)).to be false
    end

    it 'returns true when data is good' do
      medication = create(:medication, :with_daily_reminder, user_id: user.id)
      expect(active_reminders?(medication)).to be true
    end
  end

  describe '#join_names' do
    it 'correctly joins reminder names with proper connector' do
      reminders = join_names(reminder_names)
      expected_string = "name1#{t('support.array.words_connector')}name2"
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

    it 'returns correct html when data has a daily reminder' do
      medication = create(:medication, :with_daily_reminder, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = "<div><i class=\"fa fa-bell smallMarginRight\"></i>#{t('common.daily_reminder')}</div>"
      expect(reminders).to eq(expected_html)
    end

    it 'returns correct html when data has a refill reminder' do
      medication = create(:medication, :with_refill_reminder, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = "<div><i class=\"fa fa-bell smallMarginRight\"></i>#{t('medications.refill_reminder')}</div>"
      expect(reminders).to eq(expected_html)
    end

    it 'returns correct html when data has a daily reminder and refill reminder' do
      medication = create(:medication, :with_both_reminders, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = "<div><i class=\"fa fa-bell smallMarginRight\"></i>#{t('medications.refill_reminder')}, #{t('common.daily_reminder')}</div>"
      expect(reminders).to eq(expected_html)
    end

    it 'returns correct html when data has a Google calendar reminder' do
      medication = create(:medication, add_to_google_cal: true, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = "<div><i class=\"fa fa-bell smallMarginRight\"></i>#{t('medications.form.add_to_google_cal')}</div>"
      expect(reminders).to eq(expected_html)
    end

    it 'returns correct html when data has all reminders' do
      medication = create(:medication, :with_both_reminders, add_to_google_cal: true, user_id: user.id)
      reminders = print_reminders(medication)
      expected_html = "<div><i class=\"fa fa-bell smallMarginRight\"></i>#{t('medications.refill_reminder')}, #{t('common.daily_reminder')}, and #{t('medications.form.add_to_google_cal')}</div>"
      expect(reminders).to eq(expected_html)
    end
  end
end
