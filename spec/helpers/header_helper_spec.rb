describe HeaderHelper do
  describe '#header_props' do
    subject { header_props }

    before(:each) do
      allow(self).to receive('active?').and_return(false)
      allow(self).to receive('active?').with(active_path).and_return(active)
      allow(self).to receive('user_signed_in?').and_return(user_signed_in)
      allow(self).to receive('current_user').and_return(current_user)
    end

    context 'when user is signed in' do
      let(:current_user) { create :user2 }
      let(:user_signed_in) { true }
      let(:active_path) { resources_path }

      context 'has no active link' do
        let(:active) { false }
        it 'returns props with no active link ' do
          active_links = subject[:links].select { |link| link[:active] }
          expect(active_links.count).to eq(0)
        end
      end

      context 'has an active link' do
        let(:active) { true }
        it 'returns props with an active link ' do
          active_links = subject[:links].select { |link| link[:active] }
          expect(active_links.count).to eq(1)
          expect(active_links.first[:url]).to eq(active_path)
        end
      end
    end

    context 'when user is not signed in' do
      let(:current_user) { nil }
      let(:user_signed_in) { false }
      let(:active_path) { new_user_session_path }

      context 'has no active link' do
        let(:active) { false }
        it 'returns props with no active link ' do
          active_links = subject[:links].select { |link| link[:active] }
          expect(active_links.count).to eq(0)
        end
      end

      context 'has an active link' do
        let(:active) { true }
        it 'returns props with an active link ' do
          active_links = subject[:links].select { |link| link[:active] }
          expect(active_links.count).to eq(1)
          expect(active_links.first[:url]).to eq(active_path)
        end
      end
    end
  end
end