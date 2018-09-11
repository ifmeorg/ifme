describe DateTimeHelper do
  describe '#format_date' do
    context 'MM/DD/YYY format' do
      let(:date_str) { '01/14/2019' }
      it 'returns formatted value' do
        expect(format_date(date_str)).to eq('January 14, 2019')
      end
    end

    context 'DD/MM/YYY format' do
      let(:date_str) { '30/07/2019' }
      it 'returns formatted value' do
        expect(format_date(date_str)).to eq('July 30, 2019')
      end
    end
  end

  describe '#format_time' do
    context '12 hour format' do
      let(:time_str) { '1:00pm' }
      it 'returns formatted value' do
        expect(format_time(time_str)).to eq('01:00 PM')
      end
    end

    context '24 hour format' do
      let(:time_str) { '24:00' }
      it 'returns formatted value' do
        expect(format_time(time_str)).to eq('12:00 AM')
      end
    end
  end
end