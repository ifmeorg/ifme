describe ReportsController, type: :controller do
  describe '#create' do
    context 'as an authenticated user' do
      before do
        @report = create(:report)
      end

      it 'adds a report' do
        report_params = attributes_for(:report)
        expect {
          report :create, params: { report: report_params }
        }
      end
    end
  end
end
