# frozen_string_literal: true
describe ReportsHelper, type: :controller do
  controller(ReportsController) do
  end

  describe '#new_report_props' do
    subject { controller.new_report_props(uid, comment_id) }

    let(:inputs) {
      [
        {
          id: 'report_reasons',
          type: 'textarea',
          name: 'report[reasons]',
          label: 'Reasons',
          value: nil,
          required: true,
          dark: true
        },
        {
          id: 'submit',
          type: 'submit',
          value: 'Submit',
          dark: true
        }
      ]
    }

    context 'does not have comment_id' do
      let(:uid) { 'uid' }
      let(:comment_id) { nil }

      it 'returns correct props' do
        expect(subject).to eq(
          inputs: inputs,
          action: '/reports?uid=uid'
       )
      end
    end

    context 'has comment_id' do
      let(:uid) { 'uid' }
      let(:comment_id) { 'comment_id' }

      it 'returns correct props' do
        expect(subject).to eq(
          inputs: inputs,
          action: '/reports?comment_id=comment_id&uid=uid'
       )
      end
    end
  end
end