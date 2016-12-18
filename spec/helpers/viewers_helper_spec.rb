describe ViewersHelper do
  let(:owner_id) { 1 }

  let!(:viewers) do
    users = viewer_count.times.map do |i|
      create :user1, name: "Viewer #{i}"
    end
    users.map(&:id)
  end

  describe '#number_of_viewers' do
    subject { number_of_viewers(current_user_id, owner_id, viewers) }

    context 'when current_user_is_owner is true' do
      let(:current_user_id) { 1 }

      context 'and when number of viewers is 0' do
        let(:viewer_count) { 0 }

        it 'says there are no viewers' do
          expect(subject).to eq 'There are <strong>no</strong> viewers.'
        end
      end

      context 'and when number of viewers is 1' do
        let(:viewer_count) { 1 }

        it 'lists the one viewer' do
          expect(subject).to eq 'Viewer 0 is a viewer.'
        end
      end

      context 'and when number of viewers is 2' do
        let(:viewer_count) { 2 }

        it "lists the two viewers' names" do
          expect(subject).to eq 'Viewer 0 and Viewer 1 are viewers.'
        end
      end

      context 'and when number of viewers is more than 2' do
        let(:viewer_count) { 3 }

        it "lists all the viewers' names" do
          expect(subject).to eq 'Viewer 0, Viewer 1, and Viewer 2 are viewers.'
        end
      end
    end

    context 'when current_user_is_owner is false' do
      let(:current_user_id) { 6 }

      context 'and when viewer is the only viewer' do
        let(:viewer_count) { 1 }

        it 'says you are the only viewer' do
          expect(subject).to eq 'You are the only viewer.'
        end
      end

      context 'and when viewer is not the only viewer' do
        let(:viewer_count) { 2 }

        it 'says you are not the only viewer' do
          expect(subject).to eq 'You are <strong>not</strong> the only viewer.'
        end
      end
    end
  end
end
