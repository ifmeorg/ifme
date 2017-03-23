module Comments
  describe BaseService do
    context 'responds to methods' do
      subject { described_class.new(comment: double) }

      it { expect(subject).to respond_to(:create) }
      it { expect(subject).to respond_to(:delete) }
    end

    describe '#delete' do
    end

    describe 'create' do
    end
  end
end
